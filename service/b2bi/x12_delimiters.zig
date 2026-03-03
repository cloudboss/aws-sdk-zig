/// In X12 EDI messages, delimiters are used to mark the end of segments or
/// elements, and are defined in the interchange control header. The delimiters
/// are part of the message's syntax and divide up its different elements.
pub const X12Delimiters = struct {
    /// The component, or sub-element, separator. The default value is `:` (colon).
    component_separator: ?[]const u8 = null,

    /// The data element separator. The default value is `*` (asterisk).
    data_element_separator: ?[]const u8 = null,

    /// The segment terminator. The default value is `~` (tilde).
    segment_terminator: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_separator = "componentSeparator",
        .data_element_separator = "dataElementSeparator",
        .segment_terminator = "segmentTerminator",
    };
};
