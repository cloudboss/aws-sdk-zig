const SourceFrequency = @import("source_frequency.zig").SourceFrequency;
const SourceKeyword = @import("source_keyword.zig").SourceKeyword;
const SourceSetUpOption = @import("source_set_up_option.zig").SourceSetUpOption;
const SourceType = @import("source_type.zig").SourceType;

/// The data source that determines where Audit Manager collects evidence from
/// for
/// the control.
pub const ControlMappingSource = struct {
    /// The description of the source.
    source_description: ?[]const u8 = null,

    /// Specifies how often evidence is collected from the control mapping source.
    source_frequency: ?SourceFrequency = null,

    /// The unique identifier for the source.
    source_id: ?[]const u8 = null,

    source_keyword: ?SourceKeyword = null,

    /// The name of the source.
    source_name: ?[]const u8 = null,

    /// The setup option for the data source. This option reflects if the evidence
    /// collection
    /// method is automated or manual. If you don’t provide a value for
    /// `sourceSetUpOption`, Audit Manager automatically infers and populates
    /// the correct value based on the `sourceType` that you specify.
    source_set_up_option: ?SourceSetUpOption = null,

    /// Specifies which type of data source is used to collect evidence.
    ///
    /// * The source can be an individual data source type, such as
    /// `AWS_Cloudtrail`, `AWS_Config`,
    /// `AWS_Security_Hub`, `AWS_API_Call`, or `MANUAL`.
    ///
    /// * The source can also be a managed grouping of data sources, such as a
    /// `Core_Control` or a `Common_Control`.
    source_type: ?SourceType = null,

    /// The instructions for troubleshooting the control.
    troubleshooting_text: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_description = "sourceDescription",
        .source_frequency = "sourceFrequency",
        .source_id = "sourceId",
        .source_keyword = "sourceKeyword",
        .source_name = "sourceName",
        .source_set_up_option = "sourceSetUpOption",
        .source_type = "sourceType",
        .troubleshooting_text = "troubleshootingText",
    };
};
