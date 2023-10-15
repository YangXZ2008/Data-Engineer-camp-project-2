# Project plan

## Objective

The objective of our project is to provide analytical datasets from our Northwind database.

## Consumers

The users of our datasets are Data Analysts. From dashboards using Power BI and Tableau.

## Questions

> - How many order by regions, and territories and ship_countries?
> - Time between order-date and ship-date? delay in shipment, lead time
> - Which supplier has the most popular the product?
> - Which supplier can cover the most orders?
> - How many orders packed by each employee?

## Source datasets

| Source name                     | Source type         | Source documentation                                          |
| ------------------------------- | ------------------- | ------------------------------------------------------------- |
| Northwind database for Postgres | PostgreSQL database | [Source](https://github.com/pthom/northwind_psql/tree/master) |

## Solution architecture

How are we going to get data flowing from source to serving? What components and services will we combine to implement the solution? How do we automate the entire running of the solution?

- What data extraction patterns are you going to be using?
- What data loading patterns are you going to be using?
- What data transformation patterns are you going to be performing?

We recommend using a diagramming tool like [draw.io](https://draw.io/) to create your architecture diagram.

Here is a sample solution architecture diagram:

![images/sample-solution-architecture-diagram.png](images/sample-solution-architecture-diagram.png)

## Breakdown of tasks

How is your project broken down? Who is doing what?

We recommend using a free Task board such as [Trello](https://trello.com/). This makes it easy to assign and track tasks to each individual.

Example:

![images/kanban-task-board.png](images/kanban-task-board.png)
