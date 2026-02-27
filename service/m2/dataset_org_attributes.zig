const GdgAttributes = @import("gdg_attributes.zig").GdgAttributes;
const PoAttributes = @import("po_attributes.zig").PoAttributes;
const PsAttributes = @import("ps_attributes.zig").PsAttributes;
const VsamAttributes = @import("vsam_attributes.zig").VsamAttributes;

/// Additional details about the data set. Different attributes correspond to
/// different data
/// set organizations. The values are populated based on datasetOrg, storageType
/// and backend
/// (Blu Age or Micro Focus).
pub const DatasetOrgAttributes = union(enum) {
    /// The generation data group of the data set.
    gdg: ?GdgAttributes,
    /// The details of a PO type data set.
    po: ?PoAttributes,
    /// The details of a PS type data set.
    ps: ?PsAttributes,
    /// The details of a VSAM data set.
    vsam: ?VsamAttributes,

    pub const json_field_names = .{
        .gdg = "gdg",
        .po = "po",
        .ps = "ps",
        .vsam = "vsam",
    };
};
