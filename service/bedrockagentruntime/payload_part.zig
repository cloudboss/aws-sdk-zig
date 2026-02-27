const Attribution = @import("attribution.zig").Attribution;

/// Contains a part of an agent response and citations for it.
pub const PayloadPart = struct {
    /// Contains citations for a part of an agent response.
    attribution: ?Attribution,

    /// A part of the agent response in bytes.
    bytes: ?[]const u8,

    pub const json_field_names = .{
        .attribution = "attribution",
        .bytes = "bytes",
    };
};
