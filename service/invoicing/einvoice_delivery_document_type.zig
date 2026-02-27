pub const EinvoiceDeliveryDocumentType = enum {
    aws_cloud_invoice,
    aws_cloud_credit_memo,
    aws_marketplace_invoice,
    aws_marketplace_credit_memo,
    aws_request_for_payment,

    pub const json_field_names = .{
        .aws_cloud_invoice = "AWS_CLOUD_INVOICE",
        .aws_cloud_credit_memo = "AWS_CLOUD_CREDIT_MEMO",
        .aws_marketplace_invoice = "AWS_MARKETPLACE_INVOICE",
        .aws_marketplace_credit_memo = "AWS_MARKETPLACE_CREDIT_MEMO",
        .aws_request_for_payment = "AWS_REQUEST_FOR_PAYMENT",
    };
};
