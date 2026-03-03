const Xavc4kIntraVbrProfileClass = @import("xavc_4_k_intra_vbr_profile_class.zig").Xavc4kIntraVbrProfileClass;

/// Required when you set Profile to the value XAVC_4K_INTRA_VBR.
pub const Xavc4kIntraVbrProfileSettings = struct {
    /// Specify the XAVC Intra 4k (VBR) Class to set the bitrate of your output.
    /// Outputs of the same class have similar image quality over the operating
    /// points that are valid for that class.
    xavc_class: ?Xavc4kIntraVbrProfileClass = null,

    pub const json_field_names = .{
        .xavc_class = "XavcClass",
    };
};
