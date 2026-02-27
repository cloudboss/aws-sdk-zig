const Xavc4kIntraCbgProfileClass = @import("xavc_4_k_intra_cbg_profile_class.zig").Xavc4kIntraCbgProfileClass;

/// Required when you set Profile to the value XAVC_4K_INTRA_CBG.
pub const Xavc4kIntraCbgProfileSettings = struct {
    /// Specify the XAVC Intra 4k (CBG) Class to set the bitrate of your output.
    /// Outputs of the same class have similar image quality over the operating
    /// points that are valid for that class.
    xavc_class: ?Xavc4kIntraCbgProfileClass,

    pub const json_field_names = .{
        .xavc_class = "XavcClass",
    };
};
