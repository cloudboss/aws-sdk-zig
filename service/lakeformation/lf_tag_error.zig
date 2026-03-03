const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const LFTagPair = @import("lf_tag_pair.zig").LFTagPair;

/// A structure containing an error related to a `TagResource` or
/// `UnTagResource` operation.
pub const LFTagError = struct {
    /// An error that occurred with the attachment or detachment of the LF-tag.
    @"error": ?ErrorDetail = null,

    /// The key-name of the LF-tag.
    lf_tag: ?LFTagPair = null,

    pub const json_field_names = .{
        .@"error" = "Error",
        .lf_tag = "LFTag",
    };
};
