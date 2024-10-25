<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Credit salesTable</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: skyblue;
        }
        .unpaid {
            background-color: red;
            color: white;
        }
        .btn {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<h2>Safaricom</h2>
<table id="salesTable">
    <thead>
        <tr>
            <th>Date</th>
            <th>Product</th>
            <th>Quantity</th>
            <th>Amount</th>
            <th>Payment</th>
            <th>Total</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><input type="date"></td>
            <td>
                <select onchange="calculateTotal(this)">
                    <option value="10">10</option>
                    <option value="20">20</option>
                    <option value="30">50</option>
                    <option value="40">100</option>
                </select>
            </td>
            <td><input type="number" value="0" onchange="calculateTotal(this)" min="0"></td>
            <td><input type="number" value="0" onchange="calculateTotal(this)" min="0"></td>
            <td>
                <select onchange="updateRowColor(this)">
                    <option value="PAID">PAID</option>
                    <option value="UNPAID">UNPAID</option>
                </select>
            </td>
            <td><input type="text" value="0" readonly></td>
        </tr>
    </tbody>
</table>
<button class="btn" onclick="addRow()">Add Row</button>

<script>
    function calculateTotal(element) {
        const row = element.closest('tr');
        const quantity = row.cells[2].querySelector('input').value;
        const amount = row.cells[3].querySelector('input').value;
        const totalCell = row.cells[5].querySelector('input');

        // Calculate total
        totalCell.value = (quantity * amount) || 0;
    }

    function updateRowColor(select) {
        const row = select.closest('tr');
        if (select.value === 'UNPAID') {
            row.classList.add('unpaid');
        } else {
            row.classList.remove('unpaid');
        }
    }

    function addRow() {
        const tableBody = document.getElementById('salesTable').getElementsByTagName('tbody')[0];
        const newRow = tableBody.insertRow();

        newRow.innerHTML = `
            <td><input type="date"></td>
            <td>
                <select onchange="calculateTotal(this)">
                    <option value="10">10L REFILL</option>
                    <option value="20">20L REFILL</option>
                    <option value="30">20L NEW PURCHASE</option>
                    <option value="40">5L NEW PURCHASE</option>
                </select>
            </td>
            <td><input type="number" value="0" onchange="calculateTotal(this)" min="0"></td>
            <td><input type="number" value="0" onchange="calculateTotal(this)" min="0"></td>
            <td>
                <select onchange="updateRowColor(this)">
                    <option value="PAID">PAID</option>
                    <option value="UNPAID">UNPAID</option>
                </select>
            </td>
            <td><input type="text" value="0" readonly></td>
        `;
    }
</script>

</body>
</html>