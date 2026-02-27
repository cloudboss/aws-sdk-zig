const SourceFrequency = @import("source_frequency.zig").SourceFrequency;
const SourceKeyword = @import("source_keyword.zig").SourceKeyword;
const SourceSetUpOption = @import("source_set_up_option.zig").SourceSetUpOption;
const SourceType = @import("source_type.zig").SourceType;

/// The mapping attributes that determine the evidence source for a given
/// control, along
/// with related parameters and metadata. This doesn't contain `mappingID`.
pub const CreateControlMappingSource = struct {
    /// The description of the data source that determines where Audit Manager
    /// collects
    /// evidence from for the control.
    source_description: ?[]const u8,

    /// Specifies how often evidence is collected from the control mapping source.
    source_frequency: ?SourceFrequency,

    source_keyword: ?SourceKeyword,

    /// The name of the control mapping data source.
    source_name: ?[]const u8,

    /// The setup option for the data source. This option reflects if the evidence
    /// collection
    /// method is automated or manual. If you don’t provide a value for
    /// `sourceSetUpOption`, Audit Manager automatically infers and populates
    /// the correct value based on the `sourceType` that you specify.
    source_set_up_option: ?SourceSetUpOption,

    /// Specifies which type of data source is used to collect evidence.
    ///
    /// * The source can be an individual data source type, such as
    /// `AWS_Cloudtrail`, `AWS_Config`,
    /// `AWS_Security_Hub`, `AWS_API_Call`, or `MANUAL`.
    ///
    /// * The source can also be a managed grouping of data sources, such as a
    /// `Core_Control` or a `Common_Control`.
    source_type: ?SourceType,

    /// The instructions for troubleshooting the control.
    troubleshooting_text: ?[]const u8,

    pub const json_field_names = .{
        .source_description = "sourceDescription",
        .source_frequency = "sourceFrequency",
        .source_keyword = "sourceKeyword",
        .source_name = "sourceName",
        .source_set_up_option = "sourceSetUpOption",
        .source_type = "sourceType",
        .troubleshooting_text = "troubleshootingText",
    };
};
