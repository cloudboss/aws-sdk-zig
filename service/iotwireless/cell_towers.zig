const CdmaObj = @import("cdma_obj.zig").CdmaObj;
const GsmObj = @import("gsm_obj.zig").GsmObj;
const LteObj = @import("lte_obj.zig").LteObj;
const TdscdmaObj = @import("tdscdma_obj.zig").TdscdmaObj;
const WcdmaObj = @import("wcdma_obj.zig").WcdmaObj;

/// The cell towers that were used to perform the measurements.
pub const CellTowers = struct {
    /// CDMA object information.
    cdma: ?[]const CdmaObj,

    /// GSM object information.
    gsm: ?[]const GsmObj,

    /// LTE object information.
    lte: ?[]const LteObj,

    /// TD-SCDMA object information.
    tdscdma: ?[]const TdscdmaObj,

    /// WCDMA object information.
    wcdma: ?[]const WcdmaObj,

    pub const json_field_names = .{
        .cdma = "Cdma",
        .gsm = "Gsm",
        .lte = "Lte",
        .tdscdma = "Tdscdma",
        .wcdma = "Wcdma",
    };
};
