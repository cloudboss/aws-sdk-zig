const MarketoConnectorOperator = @import("marketo_connector_operator.zig").MarketoConnectorOperator;
const S3ConnectorOperator = @import("s3_connector_operator.zig").S3ConnectorOperator;
const SalesforceConnectorOperator = @import("salesforce_connector_operator.zig").SalesforceConnectorOperator;
const ServiceNowConnectorOperator = @import("service_now_connector_operator.zig").ServiceNowConnectorOperator;
const ZendeskConnectorOperator = @import("zendesk_connector_operator.zig").ZendeskConnectorOperator;

/// The operation to be performed on the provided source fields.
pub const ConnectorOperator = struct {
    /// The operation to be performed on the provided Marketo source fields.
    marketo: ?MarketoConnectorOperator = null,

    /// The operation to be performed on the provided Amazon S3 source fields.
    s3: ?S3ConnectorOperator = null,

    /// The operation to be performed on the provided Salesforce source fields.
    salesforce: ?SalesforceConnectorOperator = null,

    /// The operation to be performed on the provided ServiceNow source fields.
    service_now: ?ServiceNowConnectorOperator = null,

    /// The operation to be performed on the provided Zendesk source fields.
    zendesk: ?ZendeskConnectorOperator = null,

    pub const json_field_names = .{
        .marketo = "Marketo",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .service_now = "ServiceNow",
        .zendesk = "Zendesk",
    };
};
