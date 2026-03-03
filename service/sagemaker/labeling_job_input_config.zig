const LabelingJobDataAttributes = @import("labeling_job_data_attributes.zig").LabelingJobDataAttributes;
const LabelingJobDataSource = @import("labeling_job_data_source.zig").LabelingJobDataSource;

/// Input configuration information for a labeling job.
pub const LabelingJobInputConfig = struct {
    /// Attributes of the data specified by the customer.
    data_attributes: ?LabelingJobDataAttributes = null,

    /// The location of the input data.
    data_source: LabelingJobDataSource,

    pub const json_field_names = .{
        .data_attributes = "DataAttributes",
        .data_source = "DataSource",
    };
};
