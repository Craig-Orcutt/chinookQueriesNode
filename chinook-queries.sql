-- Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
SELECT "FirstName" , "LastName" ,"CustomerId", "Country" 
FROM Customer as c
WHERE c.Country != "USA"

-- Provide a query only showing the Customers from Brazil.
SELECT "FirstName" , "LastName" ,"CustomerId", "Country"
FROM Customer as c
WHERE c.Country = "Brazil"

-- Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName "FirstName", c.LastName "LastName" ,i.InvoiceId "InvoiceId", i.invoiceDate "InvoiceDate", i.billingCountry "Country"
FROM Customer as c
JOIN Invoice as i 
ON c.CustomerId = i.CustomerId
WHERE c.Country = "Brazil"

-- Provide a query showing only the Employees who are Sales Agents.
SELECT *
FROM Employee e
WHERE Employee.Title = "Sales Support Agent"

-- Provide a query showing a unique list of billing countries from the Invoice table.
SELECT distinct billingCountry
FROM Invoice

-- Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
SELECT e.FirstName, e.LastName, i.InvoiceId
FROM Employee e
JOIN Customer c 
ON e.EmployeeId = c.SupportRepId
JOIN Invoice i
ON i.CustomerId = e.EmployeeId
WHERE Title = "Sales Support Agent"

-- Provide a query that shows the Invoice Total, Customer name, Country and Sales Agent name for all invoices and customers.

SELECT c.LastName || " , " || c.FirstName as "Customer", i.billingCountry AS "Country", e.LastName  || " , " || e.FirstName AS "Sales Agent",   i.Total AS "Invoice Total"
FROM Employee e
JOIN Customer c
ON e.EmployeeId = c.SupportRepId
JOIN Invoice i
ON i.CustomerId = c.CustomerId
ORDER BY c.LastName ASC

--  How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?
SELECT substr(i.invoiceDate, 1 , 4) "Sales Year", COUNT(i.invoiceDate) as "Total Sales", SUM(i.Total) "Sales Total"
FROM Invoice i
WHERE substr(i.InvoiceDate, 1,4) = "2009"
OR substr(i.invoiceDate, 1,4) = "2011"
GROUP BY substr(i.invoiceDate, 1,4)

-- * Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
SELECT i.InvoiceLineId as "Line ID", COUNT(i.InvoiceLineId)  as"Line Items"
FROM InvoiceLine i
WHERE i.InvoiceId = '37'

-- * Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY
SELECT i.InvoiceId as "Line ID", COUNT(i.InvoiceLineId)  as"Line Items"
FROM InvoiceLine i
GROUP BY i.InvoiceId

-- * Provide a query that includes the track name with each invoice line item.
SELECT t.Name as "Track Name" , t.TrackId as "Track ID" , i.InvoiceLineId as "Line Item" 
FROM InvoiceLine i
JOIN Track t
ON i.TrackId = t.TrackId
ORDER BY i.InvoiceLineId ASC

-- * Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT t.Name as "Track Name" , a.Name as "Artist" , i.InvoiceLineId as "Line Item" 
FROM InvoiceLine i
JOIN Track t
ON i.TrackId = t.TrackId
JOIN Album al 
ON t.AlbumId = al.AlbumId
JOIN Artist a
ON a.ArtistId = al.ArtistId
ORDER BY i.InvoiceLineId ASC

-- * Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT i.billingCountry as "Country",COUNT(i.billingCountry) as "Invoices Per Country"
FROM Invoice i
GROUP BY i.billingCountry

-- * Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.
SELECT p.Name as "Playlist Name", COUNT(pl.TrackId) as 'No of Songs'
FROM PlaylistTrack pl
JOIN Playlist p
ON p.PlaylistId = pl.PlaylistId
GROUP BY pl.PlaylistId

-- * Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.
SELECT t.Name as "Track Name", a.Title as "Album", m.Name as "Media Type", g.Name as "Genre"
FROM Track t
JOIN Album a
ON t.AlbumId = a.AlbumId
JOIN MediaType m
ON m.MediaTypeId = t.MediaTypeId
JOIN Genre g
ON t.GenreId = g.GenreId

-- * Provide a query that shows all Invoices but includes the # of invoice line items.
SELECT i.* , COUNT(l.InvoiceLineId) as "No. of Lines"
FROM Invoice i
JOIN InvoiceLine l
ON i.InvoiceId = l.InvoiceId

-- * Provide a query that shows total sales made by each sales agent.
SELECT e.FirstName || " " || e.LastName as "Employee", SUM(i.Total) as "Total Sales"
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId

-- * Which sales agent made the most in sales in 2009?
SELECT e.FirstName || " " || e.LastName as "Employee", SUM(i.Total) as "Total Sales"
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
JOIN Invoice i
ON c.CustomerId = i.CustomerId
WHERE substr(i.InvoiceDate, 1,4) = "2009"
GROUP BY e.EmployeeId
ORDER BY e.EmployeeId DESC
LIMIT 1

-- * Which sales agent made the most in sales in 2010?
SELECT e.FirstName || " " || e.LastName as "Employee", SUM(i.Total) as "Total Sales"
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
JOIN Invoice i
ON c.CustomerId = i.CustomerId
WHERE substr(i.InvoiceDate, 1,4) = "2010"
GROUP BY e.EmployeeId
ORDER BY e.EmployeeId DESC
LIMIT 1

-- * Which sales agent made the most in sales over all?
SELECT e.FirstName || " " || e.LastName as "Employee", SUM(i.Total) as "Total Sales"
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
JOIN Invoice i
ON c.CustomerId = i.CustomerId
GROUP BY e.EmployeeId
ORDER BY e.EmployeeId DESC
LIMIT 1

-- * Provide a query that shows the # of customers assigned to each sales agent.
SELECT e.FirstName || " " || e.LastName as "Employee", SUM(c.SupportRepId) as "Total Customers"
FROM Employee e
JOIN Customer c
ON c.SupportRepId = e.EmployeeId
GROUP BY "Employee"

-- * Provide a query that shows the total sales per country. Which country's customers spent the most?
SELECT i.billingCountry as "Country", ROUND(SUM(i.Total)) as "Total Sales"
FROM Invoice i
GROUP BY i.billingCountry 
ORDER BY "Total Sales" DESC

-- * Provide a query that shows the most purchased track of 2013.
SELECT t.Name as "Track Name", a.Name as "Artist", COUNT(il.Quantity) as "Purchase Amount"
FROM Invoice i
JOIN Track t
ON t.TrackId = il.TrackId
JOIN InvoiceLine il
ON il.InvoiceLineId = i.InvoiceId
JOIN Album al
ON al.AlbumId = t.AlbumId
JOIN Artist a
ON a.ArtistId = al.ArtistId
WHERE i.InvoiceDate LIKE "2013%"
GROUP BY t.TrackId
ORDER BY "Purchase Amount" DESC


-- * Provide a query that shows the top 5 most purchased tracks over all.
SELECT t.Name as "Track Name", SUM(i.Quantity) as "Purchase Amount"
FROM InvoiceLine i
JOIN Track t
ON t.TrackId = i.TrackId
GROUP BY i.TrackId
ORDER BY "Purchase Amount" DESC
LIMIT 5

-- * Provide a query that shows the most purchased Media Type.
SELECT m.Name  as "Media Type", COUNT(m.MediaTypeId) as "Amount"
FROM InvoiceLine i
JOIN Track t
ON i.TrackId = t.TrackId
JOIN MediaType m
ON t.MediaTypeID = m.MediaTypeId
GROUP BY m.MediaTypeID
ORDER BY "Amount" DESC

-- * Provide a query that shows the number tracks purchased in all invoices that contain more than one genre.
SELECT i.InvoiceId, COUNT(i.TrackId) as "Purchased Tracks" , COUNT(DISTINCT t.GenreId) as "Genre Count"
FROM InvoiceLine i
JOIN Track t
ON i.TrackId = t.TrackId
GROUP BY i.InvoiceId
HAVING COUNT(t.GenreId) > 1 
ORDER BY "Genre Count" DESC
