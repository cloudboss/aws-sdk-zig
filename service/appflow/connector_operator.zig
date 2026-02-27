const AmplitudeConnectorOperator = @import("amplitude_connector_operator.zig").AmplitudeConnectorOperator;
const Operator = @import("operator.zig").Operator;
const DatadogConnectorOperator = @import("datadog_connector_operator.zig").DatadogConnectorOperator;
const DynatraceConnectorOperator = @import("dynatrace_connector_operator.zig").DynatraceConnectorOperator;
const GoogleAnalyticsConnectorOperator = @import("google_analytics_connector_operator.zig").GoogleAnalyticsConnectorOperator;
const InforNexusConnectorOperator = @import("infor_nexus_connector_operator.zig").InforNexusConnectorOperator;
const MarketoConnectorOperator = @import("marketo_connector_operator.zig").MarketoConnectorOperator;
const PardotConnectorOperator = @import("pardot_connector_operator.zig").PardotConnectorOperator;
const S3ConnectorOperator = @import("s3_connector_operator.zig").S3ConnectorOperator;
const SalesforceConnectorOperator = @import("salesforce_connector_operator.zig").SalesforceConnectorOperator;
const SAPODataConnectorOperator = @import("sapo_data_connector_operator.zig").SAPODataConnectorOperator;
const ServiceNowConnectorOperator = @import("service_now_connector_operator.zig").ServiceNowConnectorOperator;
const SingularConnectorOperator = @import("singular_connector_operator.zig").SingularConnectorOperator;
const SlackConnectorOperator = @import("slack_connector_operator.zig").SlackConnectorOperator;
const TrendmicroConnectorOperator = @import("trendmicro_connector_operator.zig").TrendmicroConnectorOperator;
const VeevaConnectorOperator = @import("veeva_connector_operator.zig").VeevaConnectorOperator;
const ZendeskConnectorOperator = @import("zendesk_connector_operator.zig").ZendeskConnectorOperator;

/// The operation to be performed on the provided source fields.
pub const ConnectorOperator = struct {
    /// The operation to be performed on the provided Amplitude source fields.
    amplitude: ?AmplitudeConnectorOperator,

    /// Operators supported by the custom connector.
    custom_connector: ?Operator,

    /// The operation to be performed on the provided Datadog source fields.
    datadog: ?DatadogConnectorOperator,

    /// The operation to be performed on the provided Dynatrace source fields.
    dynatrace: ?DynatraceConnectorOperator,

    /// The operation to be performed on the provided Google Analytics source
    /// fields.
    google_analytics: ?GoogleAnalyticsConnectorOperator,

    /// The operation to be performed on the provided Infor Nexus source fields.
    infor_nexus: ?InforNexusConnectorOperator,

    /// The operation to be performed on the provided Marketo source fields.
    marketo: ?MarketoConnectorOperator,

    /// The operation to be performed on the provided Salesforce Pardot source
    /// fields.
    pardot: ?PardotConnectorOperator,

    /// The operation to be performed on the provided Amazon S3 source fields.
    s3: ?S3ConnectorOperator,

    /// The operation to be performed on the provided Salesforce source fields.
    salesforce: ?SalesforceConnectorOperator,

    /// The operation to be performed on the provided SAPOData source fields.
    sapo_data: ?SAPODataConnectorOperator,

    /// The operation to be performed on the provided ServiceNow source fields.
    service_now: ?ServiceNowConnectorOperator,

    /// The operation to be performed on the provided Singular source fields.
    singular: ?SingularConnectorOperator,

    /// The operation to be performed on the provided Slack source fields.
    slack: ?SlackConnectorOperator,

    /// The operation to be performed on the provided Trend Micro source fields.
    trendmicro: ?TrendmicroConnectorOperator,

    /// The operation to be performed on the provided Veeva source fields.
    veeva: ?VeevaConnectorOperator,

    /// The operation to be performed on the provided Zendesk source fields.
    zendesk: ?ZendeskConnectorOperator,

    pub const json_field_names = .{
        .amplitude = "Amplitude",
        .custom_connector = "CustomConnector",
        .datadog = "Datadog",
        .dynatrace = "Dynatrace",
        .google_analytics = "GoogleAnalytics",
        .infor_nexus = "InforNexus",
        .marketo = "Marketo",
        .pardot = "Pardot",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .service_now = "ServiceNow",
        .singular = "Singular",
        .slack = "Slack",
        .trendmicro = "Trendmicro",
        .veeva = "Veeva",
        .zendesk = "Zendesk",
    };
};
