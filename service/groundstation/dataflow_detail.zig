const Destination = @import("destination.zig").Destination;
const Source = @import("source.zig").Source;

/// Information about a dataflow edge used in a contact.
pub const DataflowDetail = struct {
    destination: ?Destination = null,

    /// Error message for a dataflow.
    error_message: ?[]const u8 = null,

    source: ?Source = null,

    pub const json_field_names = .{
        .destination = "destination",
        .error_message = "errorMessage",
        .source = "source",
    };
};
