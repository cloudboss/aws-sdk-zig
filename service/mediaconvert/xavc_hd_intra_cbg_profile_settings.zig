const XavcInterlaceMode = @import("xavc_interlace_mode.zig").XavcInterlaceMode;
const XavcHdIntraCbgProfileClass = @import("xavc_hd_intra_cbg_profile_class.zig").XavcHdIntraCbgProfileClass;

/// Required when you set Profile to the value XAVC_HD_INTRA_CBG.
pub const XavcHdIntraCbgProfileSettings = struct {
    /// Choose the scan line type for the output. Keep the default value,
    /// Progressive, to create a progressive output, regardless of the scan type of
    /// your input. To create an interlaced output, choose Top field first or
    /// Follow, default top. Outputs that you create with this profile are always
    /// top field first when they are interlaced. When you create an interlaced
    /// output, set your output frame rate to 25 or 29.97.
    interlace_mode: ?XavcInterlaceMode = null,

    /// Specify the XAVC Intra HD (CBG) Class to set the bitrate of your output.
    /// Outputs of the same class have similar image quality over the operating
    /// points that are valid for that class.
    xavc_class: ?XavcHdIntraCbgProfileClass = null,

    pub const json_field_names = .{
        .interlace_mode = "InterlaceMode",
        .xavc_class = "XavcClass",
    };
};
