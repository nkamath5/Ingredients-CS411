CREATE PROCEDURE testing.countRecipes()
	BEGIN
		DECLARE done int default 0;
		DECLARE done2 int default 0;
		DECLARE currrecipe INT;
		DECLARE curringr INT;
		DECLARE recipe_cur CURSOR FOR SELECT DISTINCT id FROM Recipes;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
		DECLARE ingr_cur CURSOR FOR SELECT DISTINCT id FROM Ingredients;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = 1;

		
		DROP TABLE IF EXISTS countRecipes;
		CREATE TABLE countRecipes(id INT, count INT);
		
		OPEN recipe_cur;

		REPEAT
			FETCH recipe_cur INTO currrecipe;
			INSERT INTO countRecipes(id, count)
			(SELECT RecipeID, COUNT(*) 
FROM Contains 
GROUP BY RecipeID HAVING RecipeID =currrecipe);
		UNTIL done
		END REPEAT;
		Close recipe_cur;

		DROP TABLE IF EXISTS countIngredients;
		CREATE TABLE countIngredients(id INT, count INT);
		
		OPEN ingr_cur;

		REPEAT
			FETCH ingr_cur INTO curringr;

			INSERT INTO countIngredients(id, count)
			(SELECT Ingredients.ingredient_id, COUNT(*) 
FROM Contains c JOIN Ingredients i ON c.RecipeID=i.id
WHERE ingredient_id = curringr);

		UNTIL done2
		END REPEAT;
		Close ingr_cur;
	END
