const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  const allEmployees = await prisma.tbl_employee.findMany();
  console.log(allEmployees);
};

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })

module.exports = main
