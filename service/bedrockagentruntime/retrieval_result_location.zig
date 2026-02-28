const RetrievalResultConfluenceLocation = @import("retrieval_result_confluence_location.zig").RetrievalResultConfluenceLocation;
const RetrievalResultCustomDocumentLocation = @import("retrieval_result_custom_document_location.zig").RetrievalResultCustomDocumentLocation;
const RetrievalResultKendraDocumentLocation = @import("retrieval_result_kendra_document_location.zig").RetrievalResultKendraDocumentLocation;
const RetrievalResultS3Location = @import("retrieval_result_s3_location.zig").RetrievalResultS3Location;
const RetrievalResultSalesforceLocation = @import("retrieval_result_salesforce_location.zig").RetrievalResultSalesforceLocation;
const RetrievalResultSharePointLocation = @import("retrieval_result_share_point_location.zig").RetrievalResultSharePointLocation;
const RetrievalResultSqlLocation = @import("retrieval_result_sql_location.zig").RetrievalResultSqlLocation;
const RetrievalResultLocationType = @import("retrieval_result_location_type.zig").RetrievalResultLocationType;
const RetrievalResultWebLocation = @import("retrieval_result_web_location.zig").RetrievalResultWebLocation;

/// Contains information about the data source location.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `location` field
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `location` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `location` field
pub const RetrievalResultLocation = struct {
    /// The Confluence data source location.
    confluence_location: ?RetrievalResultConfluenceLocation,

    /// Specifies the location of a document in a custom data source.
    custom_document_location: ?RetrievalResultCustomDocumentLocation,

    /// The location of a document in Amazon Kendra.
    kendra_document_location: ?RetrievalResultKendraDocumentLocation,

    /// The S3 data source location.
    s_3_location: ?RetrievalResultS3Location,

    /// The Salesforce data source location.
    salesforce_location: ?RetrievalResultSalesforceLocation,

    /// The SharePoint data source location.
    share_point_location: ?RetrievalResultSharePointLocation,

    /// Specifies information about the SQL query used to retrieve the result.
    sql_location: ?RetrievalResultSqlLocation,

    /// The type of data source location.
    @"type": RetrievalResultLocationType,

    /// The web URL/URLs data source location.
    web_location: ?RetrievalResultWebLocation,

    pub const json_field_names = .{
        .confluence_location = "confluenceLocation",
        .custom_document_location = "customDocumentLocation",
        .kendra_document_location = "kendraDocumentLocation",
        .s_3_location = "s3Location",
        .salesforce_location = "salesforceLocation",
        .share_point_location = "sharePointLocation",
        .sql_location = "sqlLocation",
        .@"type" = "type",
        .web_location = "webLocation",
    };
};
