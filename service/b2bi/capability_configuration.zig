const EdiConfiguration = @import("edi_configuration.zig").EdiConfiguration;

/// A capability object. Currently, only EDI (electronic data interchange)
/// capabilities are supported. A trading capability contains the information
/// required to transform incoming EDI documents into JSON or XML outputs.
pub const CapabilityConfiguration = union(enum) {
    /// An EDI (electronic data interchange) configuration object.
    edi: ?EdiConfiguration,

    pub const json_field_names = .{
        .edi = "edi",
    };
};
