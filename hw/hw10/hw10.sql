CREATE TABLE parents AS
  SELECT "ace" AS parent, "bella" AS child UNION
  SELECT "ace"          , "charlie"        UNION
  SELECT "daisy"        , "hank"           UNION
  SELECT "finn"         , "ace"            UNION
  SELECT "finn"         , "daisy"          UNION
  SELECT "finn"         , "ginger"         UNION
  SELECT "ellie"        , "finn";

CREATE TABLE dogs AS
  SELECT "ace" AS name, "long" AS fur, 26 AS height UNION
  SELECT "bella"      , "short"      , 52           UNION
  SELECT "charlie"    , "long"       , 47           UNION
  SELECT "daisy"      , "long"       , 46           UNION
  SELECT "ellie"      , "short"      , 35           UNION
  SELECT "finn"       , "curly"      , 32           UNION
  SELECT "ginger"     , "short"      , 28           UNION
  SELECT "hank"       , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child FROM parents ,dogs  WHERE parent = name ORDER BY height DESC ;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name AS name, b.size AS size
  FROM dogs AS a, sizes AS b
  WHERE a.height > b.min AND a.height <= b.max;


-- [Optional] Filling out this helper table is recommended
CREATE TABLE siblings AS
  SELECT a.child AS sib1, b.child AS sib2
  FROM parents AS a, parents AS b
  WHERE a.parent = b.parent AND a.child < b.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT "The two siblings, " || sib1 || " and " || sib2 || ", have the same size: " || s1.size
  FROM siblings, size_of_dogs AS s1, size_of_dogs AS s2
  WHERE siblings.sib1 = s1.name 
    AND siblings.sib2 = s2.name 
    AND s1.size = s2.size;


-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
  SELECT fur, MAX(height) - MIN(height) AS height_range
  FROM dogs
  GROUP BY fur
  HAVING MIN(height) >= 0.7 * AVG(height) 
     AND MAX(height) <= 1.3 * AVG(height);

