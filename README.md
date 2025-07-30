```markdown
# 🛡️ IAM Least Privilege: Secure Lambda Access to DynamoDB

This mini project demonstrates how to enforce **IAM Least Privilege** in a serverless AWS application. It focuses on granting a Lambda function **only the permissions it truly needs** to interact with DynamoDB.

---

## 📌 Project Objectives

- Apply the **Principle of Least Privilege** using scoped IAM policies.
- Deploy a secure Lambda function that reads a single item from a DynamoDB table.
- Write Terraform code to manage all infrastructure as code.
- Validate that permissions work by invoking the API Gateway endpoint.

---

## ⚙️ Tech Stack

- **AWS Lambda** — serverless compute
- **Amazon API Gateway** — API endpoint for Lambda
- **Amazon DynamoDB** — stores sample data
- **IAM Roles & Policies** — strict permission control
- **AWS Secrets Manager** — optional for secret handling
- **Terraform** — full IaC for infrastructure
- **GitHub** — version control with proper `.gitignore`

---

## 🧱 Architecture Overview

```

Client → API Gateway → Lambda → DynamoDB
⬑ IAM Role with Least Privilege

````

---

## ✅ Least Privilege Policy Example

```hcl
resource "aws_iam_policy" "least_privilege_dynamodb" {
  name = "LeastPrivilegeDynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["dynamodb:GetItem"],
        Resource = "arn:aws:dynamodb:REGION:ACCOUNT_ID:table/YOUR_TABLE_NAME"
      }
    ]
  })
}
````

---

## 🚀 How to Deploy

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/IAMLeastPrivilege.git
   cd IAMLeastPrivilege
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Apply infrastructure**

   ```bash
   terraform apply
   ```

4. **Test your API**

   * Use `curl` or Postman to hit the API Gateway endpoint returned in the output.
   * Confirm successful response with data from DynamoDB.

---

## 🧪 How to Validate Least Privilege

* Temporarily remove permission → re-test API (should fail).
* Add `dynamodb:GetItem` only → API works again.
* Use IAM **Policy Simulator** to test and verify permissions.

---

## 🔥 Common Mistakes You’ll Avoid

✅ Never commit `.terraform/` folders or `.tfstate` to Git.

Make sure you include this `.gitignore`:

```
.terraform/
*.tfstate
*.tfstate.backup
```

---

## 📦 Cleanup

To avoid AWS charges:

```bash
terraform destroy
```

---

## ✍️ Author

Syamel Amri — Cloud Developer in Training 🇲🇾
GitHub: [@Syamel111](https://github.com/Syamel111)

---

## 📚 Related Learning Goals

* IAM Edge Cases
* Role + Policy separation
* Secure Terraform deployments
* Production-ready infrastructure practices
