const CustomConnectorDestinationProperties = @import("custom_connector_destination_properties.zig").CustomConnectorDestinationProperties;
const CustomerProfilesDestinationProperties = @import("customer_profiles_destination_properties.zig").CustomerProfilesDestinationProperties;
const EventBridgeDestinationProperties = @import("event_bridge_destination_properties.zig").EventBridgeDestinationProperties;
const HoneycodeDestinationProperties = @import("honeycode_destination_properties.zig").HoneycodeDestinationProperties;
const LookoutMetricsDestinationProperties = @import("lookout_metrics_destination_properties.zig").LookoutMetricsDestinationProperties;
const MarketoDestinationProperties = @import("marketo_destination_properties.zig").MarketoDestinationProperties;
const RedshiftDestinationProperties = @import("redshift_destination_properties.zig").RedshiftDestinationProperties;
const S3DestinationProperties = @import("s3_destination_properties.zig").S3DestinationProperties;
const SalesforceDestinationProperties = @import("salesforce_destination_properties.zig").SalesforceDestinationProperties;
const SAPODataDestinationProperties = @import("sapo_data_destination_properties.zig").SAPODataDestinationProperties;
const SnowflakeDestinationProperties = @import("snowflake_destination_properties.zig").SnowflakeDestinationProperties;
const UpsolverDestinationProperties = @import("upsolver_destination_properties.zig").UpsolverDestinationProperties;
const ZendeskDestinationProperties = @import("zendesk_destination_properties.zig").ZendeskDestinationProperties;

/// This stores the information that is required to query a particular
/// connector.
pub const DestinationConnectorProperties = struct {
    /// The properties that are required to query the custom Connector.
    custom_connector: ?CustomConnectorDestinationProperties,

    /// The properties required to query Amazon Connect Customer Profiles.
    customer_profiles: ?CustomerProfilesDestinationProperties,

    /// The properties required to query Amazon EventBridge.
    event_bridge: ?EventBridgeDestinationProperties,

    /// The properties required to query Amazon Honeycode.
    honeycode: ?HoneycodeDestinationProperties,

    /// The properties required to query Amazon Lookout for Metrics.
    lookout_metrics: ?LookoutMetricsDestinationProperties,

    /// The properties required to query Marketo.
    marketo: ?MarketoDestinationProperties,

    /// The properties required to query Amazon Redshift.
    redshift: ?RedshiftDestinationProperties,

    /// The properties required to query Amazon S3.
    s3: ?S3DestinationProperties,

    /// The properties required to query Salesforce.
    salesforce: ?SalesforceDestinationProperties,

    /// The properties required to query SAPOData.
    sapo_data: ?SAPODataDestinationProperties,

    /// The properties required to query Snowflake.
    snowflake: ?SnowflakeDestinationProperties,

    /// The properties required to query Upsolver.
    upsolver: ?UpsolverDestinationProperties,

    /// The properties required to query Zendesk.
    zendesk: ?ZendeskDestinationProperties,

    pub const json_field_names = .{
        .custom_connector = "CustomConnector",
        .customer_profiles = "CustomerProfiles",
        .event_bridge = "EventBridge",
        .honeycode = "Honeycode",
        .lookout_metrics = "LookoutMetrics",
        .marketo = "Marketo",
        .redshift = "Redshift",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .snowflake = "Snowflake",
        .upsolver = "Upsolver",
        .zendesk = "Zendesk",
    };
};
