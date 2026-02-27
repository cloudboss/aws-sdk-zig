const ZipClassificationCode = @import("zip_classification_code.zig").ZipClassificationCode;

/// The USPS zip code.
pub const UspsZip = struct {
    /// The ZIP Classification Code, or in other words what type of postal code is
    /// it.
    zip_classification_code: ?ZipClassificationCode,

    pub const json_field_names = .{
        .zip_classification_code = "ZipClassificationCode",
    };
};
