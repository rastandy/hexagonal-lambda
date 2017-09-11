data aws_iam_policy_document post-up {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${var.region}:${var.account}:log-group:/aws/lambda/post-up:*",
    ]
  }
}

module post-up-lambda {
  function_name = "post-up"
  prefix        = "${var.prefix}"
  source        = "../modules/lambda"
  policy_json   = "${data.aws_iam_policy_document.post-up.json}"

  env = {
    HTTPBIN_URL = "${var.httpbin_url}"
  }
}

module post-up-endpoint {
  account       = "${var.account}"
  function_name = "${module.post-up-lambda.function_name}"
  http_method   = "POST"
  lambda_arn    = "${module.post-up-lambda.arn}"
  parent_id     = "${data.terraform_remote_state.global.aws_api_gateway_root_resource_id}"
  path          = "up"
  region        = "${var.region}"
  rest_api_id   = "${data.terraform_remote_state.global.aws_api_gateway_rest_api_id}"
  source        = "../modules/endpoint"
}
