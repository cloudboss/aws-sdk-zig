const SourceData = @import("source_data.zig").SourceData;
const TrustAnchorType = @import("trust_anchor_type.zig").TrustAnchorType;

/// The trust anchor type and its related certificate data.
pub const Source = struct {
    /// The data field of the trust anchor depending on its type.
    source_data: ?SourceData = null,

    /// The type of the trust anchor.
    source_type: ?TrustAnchorType = null,

    pub const json_field_names = .{
        .source_data = "sourceData",
        .source_type = "sourceType",
    };
};
