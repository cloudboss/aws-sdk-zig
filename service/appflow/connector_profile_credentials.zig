const AmplitudeConnectorProfileCredentials = @import("amplitude_connector_profile_credentials.zig").AmplitudeConnectorProfileCredentials;
const CustomConnectorProfileCredentials = @import("custom_connector_profile_credentials.zig").CustomConnectorProfileCredentials;
const DatadogConnectorProfileCredentials = @import("datadog_connector_profile_credentials.zig").DatadogConnectorProfileCredentials;
const DynatraceConnectorProfileCredentials = @import("dynatrace_connector_profile_credentials.zig").DynatraceConnectorProfileCredentials;
const GoogleAnalyticsConnectorProfileCredentials = @import("google_analytics_connector_profile_credentials.zig").GoogleAnalyticsConnectorProfileCredentials;
const HoneycodeConnectorProfileCredentials = @import("honeycode_connector_profile_credentials.zig").HoneycodeConnectorProfileCredentials;
const InforNexusConnectorProfileCredentials = @import("infor_nexus_connector_profile_credentials.zig").InforNexusConnectorProfileCredentials;
const MarketoConnectorProfileCredentials = @import("marketo_connector_profile_credentials.zig").MarketoConnectorProfileCredentials;
const PardotConnectorProfileCredentials = @import("pardot_connector_profile_credentials.zig").PardotConnectorProfileCredentials;
const RedshiftConnectorProfileCredentials = @import("redshift_connector_profile_credentials.zig").RedshiftConnectorProfileCredentials;
const SalesforceConnectorProfileCredentials = @import("salesforce_connector_profile_credentials.zig").SalesforceConnectorProfileCredentials;
const SAPODataConnectorProfileCredentials = @import("sapo_data_connector_profile_credentials.zig").SAPODataConnectorProfileCredentials;
const ServiceNowConnectorProfileCredentials = @import("service_now_connector_profile_credentials.zig").ServiceNowConnectorProfileCredentials;
const SingularConnectorProfileCredentials = @import("singular_connector_profile_credentials.zig").SingularConnectorProfileCredentials;
const SlackConnectorProfileCredentials = @import("slack_connector_profile_credentials.zig").SlackConnectorProfileCredentials;
const SnowflakeConnectorProfileCredentials = @import("snowflake_connector_profile_credentials.zig").SnowflakeConnectorProfileCredentials;
const TrendmicroConnectorProfileCredentials = @import("trendmicro_connector_profile_credentials.zig").TrendmicroConnectorProfileCredentials;
const VeevaConnectorProfileCredentials = @import("veeva_connector_profile_credentials.zig").VeevaConnectorProfileCredentials;
const ZendeskConnectorProfileCredentials = @import("zendesk_connector_profile_credentials.zig").ZendeskConnectorProfileCredentials;

/// The connector-specific credentials required by a connector.
pub const ConnectorProfileCredentials = struct {
    /// The connector-specific credentials required when using Amplitude.
    amplitude: ?AmplitudeConnectorProfileCredentials = null,

    custom_connector: ?CustomConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Datadog.
    datadog: ?DatadogConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Dynatrace.
    dynatrace: ?DynatraceConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Google Analytics.
    google_analytics: ?GoogleAnalyticsConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Amazon Honeycode.
    honeycode: ?HoneycodeConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Infor Nexus.
    infor_nexus: ?InforNexusConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Marketo.
    marketo: ?MarketoConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Salesforce Pardot.
    pardot: ?PardotConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Amazon Redshift.
    redshift: ?RedshiftConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Salesforce.
    salesforce: ?SalesforceConnectorProfileCredentials = null,

    sapo_data: ?SAPODataConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using ServiceNow.
    service_now: ?ServiceNowConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Singular.
    singular: ?SingularConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Slack.
    slack: ?SlackConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Snowflake.
    snowflake: ?SnowflakeConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Trend Micro.
    trendmicro: ?TrendmicroConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Veeva.
    veeva: ?VeevaConnectorProfileCredentials = null,

    /// The connector-specific credentials required when using Zendesk.
    zendesk: ?ZendeskConnectorProfileCredentials = null,

    pub const json_field_names = .{
        .amplitude = "Amplitude",
        .custom_connector = "CustomConnector",
        .datadog = "Datadog",
        .dynatrace = "Dynatrace",
        .google_analytics = "GoogleAnalytics",
        .honeycode = "Honeycode",
        .infor_nexus = "InforNexus",
        .marketo = "Marketo",
        .pardot = "Pardot",
        .redshift = "Redshift",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .service_now = "ServiceNow",
        .singular = "Singular",
        .slack = "Slack",
        .snowflake = "Snowflake",
        .trendmicro = "Trendmicro",
        .veeva = "Veeva",
        .zendesk = "Zendesk",
    };
};
