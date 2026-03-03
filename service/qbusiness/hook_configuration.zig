const DocumentAttributeCondition = @import("document_attribute_condition.zig").DocumentAttributeCondition;

/// Provides the configuration information for invoking a Lambda function in
/// Lambda to alter document metadata and content when ingesting documents into
/// Amazon Q Business.
///
/// You can configure your Lambda function using the
/// `PreExtractionHookConfiguration` parameter if you want to apply advanced
/// alterations on the original or raw documents.
///
/// If you want to apply advanced alterations on the Amazon Q Business
/// structured documents, you must configure your Lambda function using
/// `PostExtractionHookConfiguration`.
///
/// You can only invoke one Lambda function. However, this function can invoke
/// other functions it requires.
///
/// For more information, see [Custom document
/// enrichment](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/custom-document-enrichment.html).
pub const HookConfiguration = struct {
    /// The condition used for when a Lambda function should be invoked.
    ///
    /// For example, you can specify a condition that if there are empty date-time
    /// values, then Amazon Q Business should invoke a function that inserts the
    /// current date-time.
    invocation_condition: ?DocumentAttributeCondition = null,

    /// The Amazon Resource Name (ARN) of the Lambda function during ingestion. For
    /// more information, see [Using Lambda functions for Amazon Q Business document
    /// enrichment](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/cde-lambda-operations.html).
    lambda_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a role with permission to run
    /// `PreExtractionHookConfiguration` and `PostExtractionHookConfiguration` for
    /// altering document metadata and content during the document ingestion
    /// process.
    role_arn: ?[]const u8 = null,

    /// Stores the original, raw documents or the structured, parsed documents
    /// before and after altering them. For more information, see [Data contracts
    /// for Lambda
    /// functions](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/cde-lambda-operations.html#cde-lambda-operations-data-contracts).
    s_3_bucket_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .invocation_condition = "invocationCondition",
        .lambda_arn = "lambdaArn",
        .role_arn = "roleArn",
        .s_3_bucket_name = "s3BucketName",
    };
};
