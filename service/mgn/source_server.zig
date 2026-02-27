const aws = @import("aws");

const SourceServerConnectorAction = @import("source_server_connector_action.zig").SourceServerConnectorAction;
const DataReplicationInfo = @import("data_replication_info.zig").DataReplicationInfo;
const LaunchedInstance = @import("launched_instance.zig").LaunchedInstance;
const LifeCycle = @import("life_cycle.zig").LifeCycle;
const ReplicationType = @import("replication_type.zig").ReplicationType;
const SourceProperties = @import("source_properties.zig").SourceProperties;

pub const SourceServer = struct {
    /// Source server application ID.
    application_id: ?[]const u8,

    /// Source server ARN.
    arn: ?[]const u8,

    /// Source Server connector action.
    connector_action: ?SourceServerConnectorAction,

    /// Source server data replication info.
    data_replication_info: ?DataReplicationInfo,

    /// Source server fqdn for action framework.
    fqdn_for_action_framework: ?[]const u8,

    /// Source server archived status.
    is_archived: ?bool,

    /// Source server launched instance.
    launched_instance: ?LaunchedInstance,

    /// Source server lifecycle state.
    life_cycle: ?LifeCycle,

    /// Source server replication type.
    replication_type: ?ReplicationType,

    /// Source server properties.
    source_properties: ?SourceProperties,

    /// Source server ID.
    source_server_id: ?[]const u8,

    /// Source server Tags.
    tags: ?[]const aws.map.StringMapEntry,

    /// Source server user provided ID.
    user_provided_id: ?[]const u8,

    /// Source server vCenter client id.
    vcenter_client_id: ?[]const u8,

    pub const json_field_names = .{
        .application_id = "applicationID",
        .arn = "arn",
        .connector_action = "connectorAction",
        .data_replication_info = "dataReplicationInfo",
        .fqdn_for_action_framework = "fqdnForActionFramework",
        .is_archived = "isArchived",
        .launched_instance = "launchedInstance",
        .life_cycle = "lifeCycle",
        .replication_type = "replicationType",
        .source_properties = "sourceProperties",
        .source_server_id = "sourceServerID",
        .tags = "tags",
        .user_provided_id = "userProvidedID",
        .vcenter_client_id = "vcenterClientID",
    };
};
