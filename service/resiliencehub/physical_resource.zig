const aws = @import("aws");

const AppComponent = @import("app_component.zig").AppComponent;
const LogicalResourceId = @import("logical_resource_id.zig").LogicalResourceId;
const PhysicalResourceId = @import("physical_resource_id.zig").PhysicalResourceId;
const ResourceSourceType = @import("resource_source_type.zig").ResourceSourceType;

/// Defines a physical resource. A physical resource is a resource that exists
/// in your
/// account. It can be identified using an Amazon Resource Name (ARN) or an
/// Resilience Hub-native identifier.
pub const PhysicalResource = struct {
    /// Additional configuration parameters for an Resilience Hub application. If
    /// you want to implement `additionalInfo` through the Resilience Hub console
    /// rather than using an API call, see [Configure the application configuration
    /// parameters](https://docs.aws.amazon.com/resilience-hub/latest/userguide/app-config-param.html).
    ///
    /// Currently, this parameter accepts a key-value mapping (in a string format)
    /// of only one failover region and one associated account.
    ///
    /// Key: `"failover-regions"`
    ///
    /// Value: `"[{"region":"<REGION>", "accounts":[{"id":"<ACCOUNT_ID>"}]}]"`
    additional_info: ?[]const aws.map.MapEntry([]const []const u8),

    /// The application components that belong to this resource.
    app_components: ?[]const AppComponent,

    /// Indicates if a resource is included or excluded from the assessment.
    excluded: ?bool,

    /// Logical identifier of the resource.
    logical_resource_id: LogicalResourceId,

    /// Name of the parent resource.
    parent_resource_name: ?[]const u8,

    /// Identifier of the physical resource.
    physical_resource_id: PhysicalResourceId,

    /// The name of the resource.
    resource_name: ?[]const u8,

    /// Type of resource.
    resource_type: []const u8,

    /// Type of input source.
    source_type: ?ResourceSourceType,

    pub const json_field_names = .{
        .additional_info = "additionalInfo",
        .app_components = "appComponents",
        .excluded = "excluded",
        .logical_resource_id = "logicalResourceId",
        .parent_resource_name = "parentResourceName",
        .physical_resource_id = "physicalResourceId",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
        .source_type = "sourceType",
    };
};
