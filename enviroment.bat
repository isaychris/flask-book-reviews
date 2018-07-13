@echo %off

echo "Setting FLASK_APP to application.py ..."
SET FLASK_APP=application.py

echo "Setting FLASK_DEBUG to 1 ...
SET FLASK_DEBUG=1

echo "Setting DATABASE_URL ..."
SET DATABASE_URL=postgres://rvhamkjjyrmuhp:ab326b9d1114c68abc991e7c0be4fa1045d6f82f4459dba1039189d59170e6f6@ec2-107-22-169-45.compute-1.amazonaws.com:5432/d99rs2e812feql

echo "-----------------------------------------------------"
echo "Enviroment setup complete."
