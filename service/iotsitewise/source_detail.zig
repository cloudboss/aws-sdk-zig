const KendraSourceDetail = @import("kendra_source_detail.zig").KendraSourceDetail;

/// The details of the dataset source associated with the dataset.
pub const SourceDetail = struct {
    /// Contains details about the Kendra dataset source.
    kendra: ?KendraSourceDetail,

    pub const json_field_names = .{
        .kendra = "kendra",
    };
};
