-- query 1. Write a query to find all posts made by users in specific locations such as 'Agra', 'Maharashtra', and 'West Bengal'.
select * from post;
select * from users;
select user_id, location from post where location = 'maharashtra' OR location = 'agra' OR location = 'west bengal';

-- 2. Write a query to list the top 5 most-followed hashtags on the platform.
select * from hashtags;
select * from hashtag_follow;
select h.hashtag_name, count(hf.user_id) as follower_count from hashtag_follow hf
join hashtags h 
on hf.hashtag_id = h.hashtag_id
group by h.hashtag_name
order by follower_count desc
limit 5;

-- 3. Identify the top 10 most-used hashtags in posts.
select * from hashtags;
select * from post_tags;
select h.hashtag_name, h.hashtag_id, count(p.post_id) as hashtag_used
from hashtags h join post_tags p
on h.hashtag_id = p.hashtag_id
group by hashtag_id
order by hashtag_used desc
limit 10;

-- 4. Write a query to find users who have never made any posts on the platform.
select * from post;
select * from users;
select user_id, username from users 
where user_id 
not in (select distinct user_id from post);

-- 5. Write a query to find the posts that have received the highest number of likes.
select * from post_likes;
select * from post;
select p.post_id, count(p.user_id) as liked_post from post_likes pl 
join post p 
on pl.post_id = p.post_id
group by p.post_id
order by liked_post desc
limit 3;

-- 6. Write a query to determine the average number of posts made by users.
select * from post;
select count( distinct post_id) / count(distinct user_id) as average_posts from post;

-- 7. Write a query to track the total number of logins made by each user.
select * from login;
select * from users;
select u.user_id, u.username, count(l.login_id) as total_login from users u 
left join login l 
on  u.user_id = l.user_id
group by user_id, username
order by total_login desc;

-- 8. Write a query to find any user who has liked every post on the platform.
select * from post_likes;
SELECT user_id
FROM post_likes
GROUP BY user_id
HAVING COUNT(DISTINCT post_id) = (SELECT COUNT(*) FROM post);

-- 9. Write a query to find users who have never commented on any post.
select * from comments;
select * from users;
select user_id, username from users 
where user_id 
not in (select user_id from comments);

-- 10. write a query to find any user who has commented on every post on the platform
select * from comments;
SELECT user_id
FROM comments
GROUP BY user_id
HAVING COUNT(DISTINCT post_id) = (SELECT COUNT(*) FROM post);

-- 11. Write a query to find users who are not followed by any other users.
select * from follows;
select * from users;
select u.user_id, u.username
from users u
left join follows f on u.user_id = f. followee_id
where follower_id is null;

-- 12. Write a query to find users who are not following anyone.
select * from follows;
select * from users;
select u.user_id, u.username
from users u
left join follows f on u.user_id = f. follower_id
where followee_id is null;

-- 13. Write a query to find users who have made more than five posts.
select * from post;
select * from users;
select u.user_id, u.username, count(p.post_id) as total_posts from users u
join post p
on u.user_id = p.user_id
group by u.user_id, u.username 
having total_posts>5;

-- 14. Write a query to find users who have more than 40 followers.
select * from follows;
select * from users;
select u.user_id, u.username, count(f.follower_id) as total_followers from users u 
join follows f on u.user_id = f.followee_id
group by u.user_id, u.username
having total_followers>40;

-- 15. Write a query to find comments containing specific words like "good" or "beautiful."
select * from comments;
select comment_text from comments where comment_text like "%beautiful%" or comment_text like "%good%";

-- 16. Write a query to find the posts with the longest captions.
select * from post;
select caption, length(caption) as longest_caption from post
order by longest_caption desc
limit 5;