/* eslint-disable no-restricted-syntax */
/* eslint-disable camelcase */
const express = require('express');
const qs = require('qs');

const router = express.Router([
  'mergeParams',
  'strict',
]);
const { PrismaClient } = require('@prisma/client');
const uuid = require('uuid');

const prisma = new PrismaClient({ log: ['query'] });

// This gets all the employees
router.get('/', async (req, res) => {
  let allEmployees = [];
  const query = qs.parse(req.query);
  const { sort, filter, range } = query;
  const sortParams = JSON.parse(sort);
  const [field, order] = sortParams;
  let [start, end] = range;

  allEmployees = await prisma.tbl_employee.findMany(
    {
      orderBy: {
        [field]: order === 'ASC' ? 'asc' : 'desc',
      },
    },
  );

  res.header('Access-Control-Expose-Headers', 'Content-Range');
  res.set('Content-Range', `employees 0,10/${allEmployees.length}`);
  res.json(allEmployees);

  
});

// This gets a single employee and filters to a specific tag
router.get('/:id', async (req, res) => {
  const { id } = req.params;
  const singleEmployee = await prisma.tbl_employee.findUnique({
    where: {
      id: String(id),
    },
  });
  res.json(singleEmployee);
});

// Create Employee
router.post('/', async (req, res) => {
  const { employee_name, employee_position, employee_or_manager } = req.body;

  const newEmployee = await prisma.tbl_employee.create({
    data: {
      id: String(uuid.v4()),
      employee_name,
      employee_position,
      employee_or_manager,
    },
  });
  res.json(newEmployee);
});

// Update Employee
router.put('/:id', async (req, res) => {
  const { id } = req.params;
  const { employee_name, employee_position, employee_or_manager } = req.body;
  try {
    const updateEmployee = await prisma.tbl_employee.update({
      where: {
        id: String(id),
      },
      data: {
        employee_name,
        employee_position,
        employee_or_manager,
      },
    });
    res.json(updateEmployee);
  } catch (error) {
    res.json({ error: `Employee with ID ${id} does not exist in the database` });
  }
});

// Delete Employee
router.delete('/:id', async (req, res) => {
  const { id } = req.params;

  try {
    const deleteEmployee = await prisma.tbl_employee.delete({
      where: {
        id: String(id),
      },
    });
    res.json(deleteEmployee);
  } catch (error) {
    res.json({ error: `Employee with ID ${id} does not exist in the database` });
  }
});

module.exports = router;
