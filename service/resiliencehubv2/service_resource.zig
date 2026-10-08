const InputSource = @import("input_source.zig").InputSource;
const Resource = @import("resource.zig").Resource;

/// Represents a resource associated with a service.
pub const ServiceResource = struct {
    /// The input source that discovered the resource.
    input_source: ?InputSource = null,

    /// The resource details.
    resource: Resource,

    /// The identifier of the resource.
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .input_source = "inputSource",
        .resource = "resource",
        .resource_identifier = "resourceIdentifier",
    };
};
