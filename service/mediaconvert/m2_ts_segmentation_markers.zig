/// Inserts segmentation markers at each segmentation_time period. rai_segstart
/// sets the Random Access Indicator bit in the adaptation field. rai_adapt sets
/// the RAI bit and adds the current timecode in the private data bytes.
/// psi_segstart inserts PAT and PMT tables at the start of segments. ebp adds
/// Encoder Boundary Point information to the adaptation field as per OpenCable
/// specification OC-SP-EBP-I01-130118. ebp_legacy adds Encoder Boundary Point
/// information to the adaptation field using a legacy proprietary format.
pub const M2tsSegmentationMarkers = enum {
    none,
    rai_segstart,
    rai_adapt,
    psi_segstart,
    ebp,
    ebp_legacy,

    pub const json_field_names = .{
        .none = "NONE",
        .rai_segstart = "RAI_SEGSTART",
        .rai_adapt = "RAI_ADAPT",
        .psi_segstart = "PSI_SEGSTART",
        .ebp = "EBP",
        .ebp_legacy = "EBP_LEGACY",
    };
};
