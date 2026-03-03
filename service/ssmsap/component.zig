const AssociatedHost = @import("associated_host.zig").AssociatedHost;
const ComponentType = @import("component_type.zig").ComponentType;
const DatabaseConnection = @import("database_connection.zig").DatabaseConnection;
const Host = @import("host.zig").Host;
const Resilience = @import("resilience.zig").Resilience;
const ComponentStatus = @import("component_status.zig").ComponentStatus;

/// The SAP component of your application.
pub const Component = struct {
    /// The ID of the application.
    application_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the component.
    arn: ?[]const u8 = null,

    /// The associated host of the component.
    associated_host: ?AssociatedHost = null,

    /// The child components of a highly available environment. For example, in a
    /// highly available SAP on AWS workload, the child component consists of the
    /// primary and secondar instances.
    child_components: ?[]const []const u8 = null,

    /// The ID of the component.
    component_id: ?[]const u8 = null,

    /// The type of the component.
    component_type: ?ComponentType = null,

    /// The connection specifications for the database of the component.
    database_connection: ?DatabaseConnection = null,

    /// The SAP HANA databases of the component.
    databases: ?[]const []const u8 = null,

    /// The SAP HANA version of the component.
    hdb_version: ?[]const u8 = null,

    /// The hosts of the component.
    hosts: ?[]const Host = null,

    /// The time at which the component was last updated.
    last_updated: ?i64 = null,

    /// The parent component of a highly available environment. For example, in a
    /// highly available SAP on AWS workload, the parent component consists of the
    /// entire setup, including the child components.
    parent_component: ?[]const u8 = null,

    /// The primary host of the component.
    primary_host: ?[]const u8 = null,

    /// Details of the SAP HANA system replication for the component.
    resilience: ?Resilience = null,

    /// The SAP feature of the component.
    sap_feature: ?[]const u8 = null,

    /// The hostname of the component.
    sap_hostname: ?[]const u8 = null,

    /// The kernel version of the component.
    sap_kernel_version: ?[]const u8 = null,

    /// The SAP System Identifier of the application component.
    sid: ?[]const u8 = null,

    /// The status of the component.
    ///
    /// * ACTIVATED - this status has been deprecated.
    /// * STARTING - the component is in the process of being started.
    /// * STOPPED - the component is not running.
    /// * STOPPING - the component is in the process of being stopped.
    /// * RUNNING - the component is running.
    /// * RUNNING_WITH_ERROR - one or more child component(s) of the parent
    ///   component is not running. Call [ `GetComponent`
    ///   ](https://docs.aws.amazon.com/ssmsap/latest/APIReference/API_GetComponent.html) to review the status of each child component.
    /// * UNDEFINED - AWS Systems Manager for SAP cannot provide the component
    ///   status based on the discovered information. Verify your SAP application.
    status: ?ComponentStatus = null,

    /// The SAP system number of the application component.
    system_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .associated_host = "AssociatedHost",
        .child_components = "ChildComponents",
        .component_id = "ComponentId",
        .component_type = "ComponentType",
        .database_connection = "DatabaseConnection",
        .databases = "Databases",
        .hdb_version = "HdbVersion",
        .hosts = "Hosts",
        .last_updated = "LastUpdated",
        .parent_component = "ParentComponent",
        .primary_host = "PrimaryHost",
        .resilience = "Resilience",
        .sap_feature = "SapFeature",
        .sap_hostname = "SapHostname",
        .sap_kernel_version = "SapKernelVersion",
        .sid = "Sid",
        .status = "Status",
        .system_number = "SystemNumber",
    };
};
