const express = require('express');
const router = express.Router();
const { PrismaClient } = require('@prisma/client');
const uuid = require('uuid');

const prisma = new PrismaClient();

//This gets all the employees
router.get('/', async (req, res) => {
    const allEmployees = await prisma.tblEmployee.findMany();
    res.json(allEmployees);

});

//This gets a single employee
router.get('/:id', async (req, res) => {
    const { id } = req.params;
    const singleEmployee = await prisma.tblEmployee.findUnique({
        where: {
            id: String(id)
        }
    })
    res.json(singleEmployee);
});

//Create Employee
router.post('/', async (req, res) => {
    const { employeeName, employeePosition, employeeOrManager } = req.body;

    const newEmployee = await prisma.tblEmployee.create({
        data: {
            id: String(uuid.v4()),
            employeeName,
            employeePosition,
            employeeOrManager,
        }
    })
    res.json(newEmployee);
});

//Update Employee
router.put('/:id', async (req, res) => {
    const { id } = req.params;
    const { employeeName, employeePosition, employeeOrManager } = req.body;
    try {
        const updateEmployee = await prisma.tblEmployee.update({
            where: {
                id: String(id),
            },
            data: {
                employeeName,
                employeePosition,
                employeeOrManager
            }
        })
        res.json(updateEmployee);
    } catch (error) {
        res.json({ error: `Employee with ID ${id} does not exist in the database` })
    }

});


//Delete Employee
router.delete('/:id', async (req, res) => {
    const { id } = req.params;

    const deleteEmployee = await prisma.tblEmployee.delete({
        where: {
            id: String(id),
        }
    })
    res.json(deleteEmployee);

});

module.exports = router;