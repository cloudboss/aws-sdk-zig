const None = @import("none.zig").None;
const DisplayContentOverrides = @import("display_content_overrides.zig").DisplayContentOverrides;

/// Represents the endpoint display content.
pub const EndpointDisplayContent = struct {
    /// If your product REST endpoint contains no overrides, the none object is
    /// returned.
    none: ?None,

    /// The overrides for endpoint display content.
    overrides: ?DisplayContentOverrides,

    pub const json_field_names = .{
        .none = "None",
        .overrides = "Overrides",
    };
};
