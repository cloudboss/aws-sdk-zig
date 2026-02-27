const GdgDetailAttributes = @import("gdg_detail_attributes.zig").GdgDetailAttributes;
const PoDetailAttributes = @import("po_detail_attributes.zig").PoDetailAttributes;
const PsDetailAttributes = @import("ps_detail_attributes.zig").PsDetailAttributes;
const VsamDetailAttributes = @import("vsam_detail_attributes.zig").VsamDetailAttributes;

/// Additional details about the data set. Different attributes correspond to
/// different data
/// set organizations. The values are populated based on datasetOrg, storageType
/// and backend
/// (Blu Age or Micro Focus).
pub const DatasetDetailOrgAttributes = union(enum) {
    /// The generation data group of the data set.
    gdg: ?GdgDetailAttributes,
    /// The details of a PO type data set.
    po: ?PoDetailAttributes,
    /// The details of a PS type data set.
    ps: ?PsDetailAttributes,
    /// The details of a VSAM data set.
    vsam: ?VsamDetailAttributes,

    pub const json_field_names = .{
        .gdg = "gdg",
        .po = "po",
        .ps = "ps",
        .vsam = "vsam",
    };
};
