/// Provided configuration information for the worker UI for a labeling job.
/// Provide either `HumanTaskUiArn` or `UiTemplateS3Uri`.
///
/// For named entity recognition, 3D point cloud and video frame labeling jobs,
/// use `HumanTaskUiArn`.
///
/// For all other Ground Truth built-in task types and custom task types, use
/// `UiTemplateS3Uri` to specify the location of a worker task template in
/// Amazon S3.
pub const UiConfig = struct {
    /// The ARN of the worker task template used to render the worker UI and tools
    /// for labeling job tasks.
    ///
    /// Use this parameter when you are creating a labeling job for named entity
    /// recognition, 3D point cloud and video frame labeling jobs. Use your labeling
    /// job task type to select one of the following ARNs and use it with this
    /// parameter when you create a labeling job. Replace `aws-region` with the
    /// Amazon Web Services Region you are creating your labeling job in. For
    /// example, replace `aws-region` with `us-west-1` if you create a labeling job
    /// in US West (N. California).
    ///
    /// **Named Entity Recognition**
    ///
    /// Use the following `HumanTaskUiArn` for named entity recognition labeling
    /// jobs:
    ///
    /// `arn:aws:sagemaker:aws-region:394669845002:human-task-ui/NamedEntityRecognition`
    ///
    /// **3D Point Cloud HumanTaskUiArns**
    ///
    /// Use this `HumanTaskUiArn` for 3D point cloud object detection and 3D point
    /// cloud object detection adjustment labeling jobs.
    ///
    /// *
    ///   `arn:aws:sagemaker:aws-region:394669845002:human-task-ui/PointCloudObjectDetection`
    ///
    /// Use this `HumanTaskUiArn` for 3D point cloud object tracking and 3D point
    /// cloud object tracking adjustment labeling jobs.
    ///
    /// *
    ///   `arn:aws:sagemaker:aws-region:394669845002:human-task-ui/PointCloudObjectTracking`
    ///
    /// Use this `HumanTaskUiArn` for 3D point cloud semantic segmentation and 3D
    /// point cloud semantic segmentation adjustment labeling jobs.
    ///
    /// *
    ///   `arn:aws:sagemaker:aws-region:394669845002:human-task-ui/PointCloudSemanticSegmentation`
    ///
    /// **Video Frame HumanTaskUiArns**
    ///
    /// Use this `HumanTaskUiArn` for video frame object detection and video frame
    /// object detection adjustment labeling jobs.
    ///
    /// * `arn:aws:sagemaker:region:394669845002:human-task-ui/VideoObjectDetection`
    ///
    /// Use this `HumanTaskUiArn` for video frame object tracking and video frame
    /// object tracking adjustment labeling jobs.
    ///
    /// *
    ///   `arn:aws:sagemaker:aws-region:394669845002:human-task-ui/VideoObjectTracking`
    human_task_ui_arn: ?[]const u8,

    /// The Amazon S3 bucket location of the UI template, or worker task template.
    /// This is the template used to render the worker UI and tools for labeling job
    /// tasks. For more information about the contents of a UI template, see [
    /// Creating Your Custom Labeling Task
    /// Template](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-custom-templates-step2.html).
    ui_template_s3_uri: ?[]const u8,

    pub const json_field_names = .{
        .human_task_ui_arn = "HumanTaskUiArn",
        .ui_template_s3_uri = "UiTemplateS3Uri",
    };
};
