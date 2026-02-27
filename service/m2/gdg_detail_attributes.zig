/// The required attributes for a generation data group data set. A generation
/// data set is
/// one of a collection of successive, historically related, catalogued data
/// sets that together
/// are known as a generation data group (GDG). Use this structure when you want
/// to import a
/// GDG. For more information on GDG, see [Generation
/// data
/// sets](https://www.ibm.com/docs/en/zos/2.3.0?topic=guide-generation-data-sets).
pub const GdgDetailAttributes = struct {
    /// The maximum number of generation data sets, up to 255, in a GDG.
    limit: i32 = 0,

    /// The disposition of the data set in the catalog.
    roll_disposition: ?[]const u8,

    pub const json_field_names = .{
        .limit = "limit",
        .roll_disposition = "rollDisposition",
    };
};
