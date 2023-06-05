# User Stories

These user stories will require you to build many pages. This repo includes wireframes for the following pages:

* [Merchant Dashboard](./wireframes/Merchant_Dashboard.png)
* [Merchant Items Index](./wireframes/Merchant_Items.png)
* [Merchant Items Show](./wireframes/Merchant_Item_Show.png)
* [Merchant Invoices Index](./wireframes/Merchant_Invoices.png)
* [Merchant Invoices Show](./wireframes/Merchant_Invoice_Show.png)
* [Admin Dashboard](./wireframes/Admin_Dashboard.png)
* [Admin Merchants Index](./wireframes/Admin_Merchants.png)
* [Admin Merchants Show](./wireframes/Admin_Merchant_Show.png)
* [Admin Invoices Index](./wireframes/Admin_Invoices.png)
* [Admin Invoices Show](./wireframes/Admin_Invoice_Show.png)

## Merchants

### Merchant Dashboard

```
1. Merchant Dashboard

As a merchant,
When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
Then I see the name of my merchant
```

```
2. Merchant Dashboard Links

As a merchant,
When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
Then I see link to my merchant items index (/merchants/:merchant_id/items)
And I see a link to my merchant invoices index (/merchants/:merchant_id/invoices)
```

```
3. Merchant Dashboard Statistics - Favorite Customers

As a merchant,
When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions with my merchant
And next to each customer name I see the number of successful transactions they have
conducted with my merchant
```

```
4. Merchant Dashboard Items Ready to Ship.

As a merchant
When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
Then I see a section for "Items Ready to Ship"
In that section I see a list of the names of all of my items that
have been ordered and have not yet been shipped,
And next to each Item I see the id of the invoice that ordered my item
And each invoice id is a link to my merchant's invoice show page
```

```
5. Merchant Dashboard Invoices sorted by least recent

As a merchant
When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
In the section for "Items Ready to Ship",
Next to each Item name I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest
```

###  Merchant Items

```
6. Merchant Items Index Page

As a merchant,
When I visit my merchant items index page (merchants/:merchant_id/items)
I see a list of the names of all of my items
And I do not see items for any other merchant
```

```
7. Merchant Items Show Page

As a merchant,
When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
And I see all of the item's attributes including:

- Name
- Description
- Current Selling Price
```

```
8. Merchant Item Update

As a merchant,
When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
I see a link to update the item information.
When I click the link
Then I am taken to a page to edit this item
And I see a form filled in with the existing item attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the item show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.
```

```
9. Merchant Item Disable/Enable

As a merchant
When I visit my items index page (/merchants/:merchant_id/items)
Next to each item name I see a button to disable or enable that item.
When I click this button
Then I am redirected back to the items index
And I see that the items status has changed
```

```
10. Merchant Items Grouped by Status

As a merchant,
When I visit my merchant items index page
Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
And I see that each Item is listed in the appropriate section
```

```
11. Merchant Item Create

As a merchant
When I visit my items index page
I see a link to create a new item.
When I click on the link,
I am taken to a form that allows me to add item information.
When I fill out the form I click ‘Submit’
Then I am taken back to the items index page
And I see the item I just created displayed in the list of items.
And I see my item was created with a default status of disabled.
```

```
12. Merchant Items Index: 5 most popular items

As a merchant
When I visit my items index page
Then I see the names of the top 5 most popular items ranked by total revenue generated
And I see that each item name links to my merchant item show page for that item
And I see the total revenue generated next to each item name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
```

```
13. Merchant Items Index: Top Item's Best Day

As a merchant
When I visit my items index page
Then next to each of the 5 most popular items I see the date with the most sales for each item.
And I see a label “Top selling date for <item name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
```

### Merchant Invoices

When a customer purchases something from the shop, a new invoice will be created in the system. A Merchant needs to be able to fulfill orders for their items on invoices.

```
14. Merchant Invoices Index

As a merchant,
When I visit my merchant's invoices index (/merchants/:merchant_id/invoices)
Then I see all of the invoices that include at least one of my merchant's items
And for each invoice I see its id
And each id links to the merchant invoice show page
```

```
15. Merchant Invoice Show Page

As a merchant
When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name
```

```
16. Merchant Invoice Show Page: Invoice Item Information

As a merchant
When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
Then I see all of my items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status
And I do not see any information related to Items for other merchants
```

```
17. Merchant Invoice Show Page: Total Revenue

As a merchant
When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
Then I see the total revenue that will be generated from all of my items on the invoice
```

```
18. Merchant Invoice Show Page: Update Item Status

As a merchant
When I visit my merchant invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
I see that each invoice item status is a select field
And I see that the invoice item's current status is selected
When I click this select field,
Then I can select a new status for the Item,
And next to the select field I see a button to "Update Item Status"
When I click this button
I am taken back to the merchant invoice show page
And I see that my Item's status has now been updated
```

## Admins

### Admin Dashboard

```
19. Admin Dashboard

As an admin,
When I visit the admin dashboard (/admin)
Then I see a header indicating that I am on the admin dashboard
```

```
20. Admin Dashboard Links

As an admin,
When I visit the admin dashboard (/admin)
Then I see a link to the admin merchants index (/admin/merchants)
And I see a link to the admin invoices index (/admin/invoices)
```

```
21. Admin Dashboard Statistics - Top Customers

As an admin,
When I visit the admin dashboard (/admin)
Then I see the names of the top 5 customers
who have conducted the largest number of successful transactions
And next to each customer name I see the number of successful transactions they have
conducted
```

```
22. Admin Dashboard Incomplete Invoices

As an admin,
When I visit the admin dashboard (/admin)
Then I see a section for "Incomplete Invoices"
In that section I see a list of the ids of all invoices
That have items that have not yet been shipped
And each invoice id links to that invoice's admin show page
```

```
23. Admin Dashboard Invoices sorted by least recent

As an admin,
When I visit the admin dashboard (/admin)
In the section for "Incomplete Invoices",
Next to each invoice id I see the date that the invoice was created
And I see the date formatted like "Monday, July 18, 2019"
And I see that the list is ordered from oldest to newest
```

### Admin Merchants

```
24. Admin Merchants Index

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then I see the name of each merchant in the system
```

```
25. Admin Merchant Show

As an admin,
When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
And I see the name of that merchant
```

```
26. Admin Merchant Update

As an admin,
When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
Then I see a link to update the merchant's information.
When I click the link
Then I am taken to a page to edit this merchant
And I see a form filled in with the existing merchant attribute information
When I update the information in the form and I click ‘submit’
Then I am redirected back to the merchant's admin show page where I see the updated information
And I see a flash message stating that the information has been successfully updated.
```

```
27. Admin Merchant Enable/Disable

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then next to each merchant name I see a button to disable or enable that merchant.
When I click this button
Then I am redirected back to the admin merchants index
And I see that the merchant's status has changed
```

```
28. Admin Merchants Grouped by Status

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then I see two sections, one for "Enabled Merchants" and one for "Disabled Merchants"
And I see that each Merchant is listed in the appropriate section
```

```
29. Admin Merchant Create

As an admin,
When I visit the admin merchants index (/admin/merchants)
I see a link to create a new merchant.
When I click on the link,
I am taken to a form that allows me to add merchant information.
When I fill out the form I click ‘Submit’
Then I am taken back to the admin merchants index page
And I see the merchant I just created displayed
And I see my merchant was created with a default status of disabled.
```

```
30. Admin Merchants: Top 5 Merchants by Revenue

As an admin,
When I visit the admin merchants index (/admin/merchants)
Then I see the names of the top 5 merchants by total revenue generated
And I see that each merchant name links to the admin merchant show page for that merchant
And I see the total revenue generated next to each merchant name

Notes on Revenue Calculation:
- Only invoices with at least one successful transaction should count towards revenue
- Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
- Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
```

```
31. Admin Merchants: Top Merchant's Best Day

As an admin,
When I visit the admin merchants index
Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
And I see a label “Top selling date for <merchant name> was <date with most sales>"

Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
```

### Admin Invoices

```
32. Admin Invoices Index Page

As an admin,
When I visit the admin Invoices index (/admin/invoices)
Then I see a list of all Invoice ids in the system
Each id links to the admin invoice show page
```

```
33. Admin Invoice Show Page

As an admin,
When I visit an admin invoice show page (/admin/invoices/:invoice_id)
Then I see information related to that invoice including:
- Invoice id
- Invoice status
- Invoice created_at date in the format "Monday, July 18, 2019"
- Customer first and last name
```

```
34. Admin Invoice Show Page: Invoice Item Information

As an admin
When I visit an admin invoice show page (/admin/invoices/:invoice_id)
Then I see all of the items on the invoice including:
- Item name
- The quantity of the item ordered
- The price the Item sold for
- The Invoice Item status
```

```
35. Admin Invoice Show Page: Total Revenue

As an admin
When I visit an admin invoice show page (/admin/invoices/:invoice_id)
Then I see the total revenue that will be generated from this invoice.
```

```
36. Admin Invoice Show Page: Update Invoice Status

As an admin
When I visit an admin invoice show page (/admin/invoices/:invoice_id)
I see the invoice status is a select field
And I see that the invoice's current status is selected
When I click this select field,
Then I can select a new status for the Invoice,
And next to the select field I see a button to "Update Invoice Status"
When I click this button
I am taken back to the admin invoice show page
And I see that my Invoice's status has now been updated
```

## API Consumption

For each of these stories, you will need to hit an endpoint provided by the [Unsplash API](https://unsplash.com/developers) in order to serve the data required on your site.

```
37. Unsplash API: App Logo

As a visitor or an admin user
When I visit any page on the site
I see the logo image at the top of every page

Note: You can choose which picture from Unsplash you'd like to be your app's logo. DO NOT save the image to your repo, but instead serve it up via the API.
```

```
38. Unsplash API: Item Image

As a visitor or an admin user
When I visit the Merchant Item Show page (/merchants/:merchant_id/items/:item_id)
I see a photo related to that item's name
```

```
39. Unsplash API: Merchant Image

As a visitor or an admin user
When I visit a Merchant's Dashboard (/merchants/:merchant_id/dashboard)
I see a random photo near the name of the Merchant
This photo should update to a new random photo each time the page is refreshed.
```

```
40. Unsplash API: Logo Image Like History

As a visitor or an admin user
When I visit any page on the site
I see that next to the app logo is the number of likes that image has.

Note: Communicate with your teammate that is working on the first API story to make sure you're gathering statistics for the same image that they're displaying as the logo.
```
