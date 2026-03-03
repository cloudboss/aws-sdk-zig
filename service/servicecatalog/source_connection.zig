const SourceConnectionParameters = @import("source_connection_parameters.zig").SourceConnectionParameters;
const SourceType = @import("source_type.zig").SourceType;

/// A top level `ProductViewDetail` response containing details about the
/// product’s connection.
/// Service Catalog returns this field for the `CreateProduct`, `UpdateProduct`,
/// `DescribeProductAsAdmin`, and `SearchProductAsAdmin` APIs.
/// This response contains the same fields as the `ConnectionParameters`
/// request, with the
/// addition of the `LastSync` response.
pub const SourceConnection = struct {
    /// The connection details based on the connection `Type`.
    connection_parameters: SourceConnectionParameters,

    /// The only supported `SourceConnection` type is Codestar.
    @"type": ?SourceType = null,

    pub const json_field_names = .{
        .connection_parameters = "ConnectionParameters",
        .@"type" = "Type",
    };
};
