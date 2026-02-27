const CopyProtectionAction = @import("copy_protection_action.zig").CopyProtectionAction;
const VchipAction = @import("vchip_action.zig").VchipAction;

/// If your source content has EIA-608 Line 21 Data Services, enable this
/// feature to specify what MediaConvert does with the Extended Data Services
/// (XDS) packets. You can choose to pass through XDS packets, or remove them
/// from the output. For more information about XDS, see EIA-608 Line Data
/// Services, section 9.5.1.5 05h Content Advisory.
pub const ExtendedDataServices = struct {
    /// The action to take on copy and redistribution control XDS packets. If you
    /// select PASSTHROUGH, packets will not be changed. If you select STRIP, any
    /// packets will be removed in output captions.
    copy_protection_action: ?CopyProtectionAction,

    /// The action to take on content advisory XDS packets. If you select
    /// PASSTHROUGH, packets will not be changed. If you select STRIP, any packets
    /// will be removed in output captions.
    vchip_action: ?VchipAction,

    pub const json_field_names = .{
        .copy_protection_action = "CopyProtectionAction",
        .vchip_action = "VchipAction",
    };
};
