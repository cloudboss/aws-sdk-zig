const XavcHdIntraCbgProfileClass = @import("xavc_hd_intra_cbg_profile_class.zig").XavcHdIntraCbgProfileClass;

/// Required when you set Profile to the value XAVC_HD_INTRA_CBG.
pub const XavcHdIntraCbgProfileSettings = struct {
    /// Specify the XAVC Intra HD (CBG) Class to set the bitrate of your output.
    /// Outputs of the same class have similar image quality over the operating
    /// points that are valid for that class.
    xavc_class: ?XavcHdIntraCbgProfileClass = null,

    pub const json_field_names = .{
        .xavc_class = "XavcClass",
    };
};
