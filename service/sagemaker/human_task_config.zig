const AnnotationConsolidationConfig = @import("annotation_consolidation_config.zig").AnnotationConsolidationConfig;
const PublicWorkforceTaskPrice = @import("public_workforce_task_price.zig").PublicWorkforceTaskPrice;
const UiConfig = @import("ui_config.zig").UiConfig;

/// Information required for human workers to complete a labeling task.
pub const HumanTaskConfig = struct {
    /// Configures how labels are consolidated across human workers.
    annotation_consolidation_config: ?AnnotationConsolidationConfig,

    /// Defines the maximum number of data objects that can be labeled by human
    /// workers at the same time. Also referred to as batch size. Each object may
    /// have more than one worker at one time. The default value is 1000 objects. To
    /// increase the maximum value to 5000 objects, contact Amazon Web Services
    /// Support.
    max_concurrent_task_count: ?i32,

    /// The number of human workers that will label an object.
    number_of_human_workers_per_data_object: i32,

    /// The Amazon Resource Name (ARN) of a Lambda function that is run before a
    /// data object is sent to a human worker. Use this function to provide input to
    /// a custom labeling job.
    ///
    /// For [built-in task
    /// types](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-task-types.html),
    /// use one of the following Amazon SageMaker Ground Truth Lambda function ARNs
    /// for `PreHumanTaskLambdaArn`. For custom labeling workflows, see
    /// [Pre-annotation
    /// Lambda](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-custom-templates-step3.html#sms-custom-templates-step3-prelambda).
    ///
    /// **Bounding box** - Finds the most similar boxes from different workers based
    /// on the Jaccard index of the boxes.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ca-central-1:918755190332:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:eu-central-1:203001061592:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-BoundingBox`
    /// * `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-BoundingBox`
    ///
    /// **Image classification** - Uses a variant of the Expectation Maximization
    /// approach to estimate the true class of an image based on annotations from
    /// individual workers.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ca-central-1:918755190332:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:eu-central-1:203001061592:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-ImageMultiClass`
    /// * `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-ImageMultiClass`
    ///
    /// **Multi-label image classification** - Uses a variant of the Expectation
    /// Maximization approach to estimate the true classes of an image based on
    /// annotations from individual workers.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-ImageMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-ImageMultiClassMultiLabel`
    ///
    /// **Semantic segmentation** - Treats each pixel in an image as a multi-class
    /// classification and treats pixel annotations from workers as "votes" for the
    /// correct label.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-SemanticSegmentation`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-SemanticSegmentation`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-SemanticSegmentation`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-SemanticSegmentation`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-SemanticSegmentation`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-SemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-SemanticSegmentation`
    ///
    /// **Text classification** - Uses a variant of the Expectation Maximization
    /// approach to estimate the true class of text based on annotations from
    /// individual workers.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ca-central-1:918755190332:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:eu-central-1:203001061592:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-TextMultiClass`
    /// * `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-TextMultiClass`
    ///
    /// **Multi-label text classification** - Uses a variant of the Expectation
    /// Maximization approach to estimate the true classes of text based on
    /// annotations from individual workers.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-TextMultiClassMultiLabel`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-TextMultiClassMultiLabel`
    ///
    /// **Named entity recognition** - Groups similar selections and calculates
    /// aggregate boundaries, resolving to most-assigned label.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-NamedEntityRecognition`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-NamedEntityRecognition`
    ///
    /// **Video Classification** - Use this task type when you need workers to
    /// classify videos using predefined labels that you specify. Workers are shown
    /// videos and are asked to choose one label for each video.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:eu-central-1:203001061592:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-VideoMultiClass`
    /// * `arn:aws:lambda:ca-central-1:918755190332:function:PRE-VideoMultiClass`
    ///
    /// **Video Frame Object Detection** - Use this task type to have workers
    /// identify and locate objects in a sequence of video frames (images extracted
    /// from a video) using bounding boxes. For example, you can use this task to
    /// ask workers to identify and localize various objects in a series of video
    /// frames, such as cars, bikes, and pedestrians.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-VideoObjectDetection`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-VideoObjectDetection`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-VideoObjectDetection`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-VideoObjectDetection`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-VideoObjectDetection`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-VideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-VideoObjectDetection`
    ///
    /// **Video Frame Object Tracking** - Use this task type to have workers track
    /// the movement of objects in a sequence of video frames (images extracted from
    /// a video) using bounding boxes. For example, you can use this task to ask
    /// workers to track the movement of objects, such as cars, bikes, and
    /// pedestrians.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-VideoObjectTracking`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-VideoObjectTracking`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-VideoObjectTracking`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-VideoObjectTracking`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-VideoObjectTracking`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-VideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-VideoObjectTracking`
    ///
    /// **3D Point Cloud Modalities**
    ///
    /// Use the following pre-annotation lambdas for 3D point cloud labeling
    /// modality tasks. See [3D Point Cloud Task types
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-point-cloud-task-types.html) to learn more.
    ///
    /// **3D Point Cloud Object Detection** - Use this task type when you want
    /// workers to classify objects in a 3D point cloud by drawing 3D cuboids around
    /// objects. For example, you can use this task type to ask workers to identify
    /// different types of objects in a point cloud, such as cars, bikes, and
    /// pedestrians.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-3DPointCloudObjectDetection`
    ///
    /// **3D Point Cloud Object Tracking** - Use this task type when you want
    /// workers to draw 3D cuboids around objects that appear in a sequence of 3D
    /// point cloud frames. For example, you can use this task type to ask workers
    /// to track the movement of vehicles across multiple point cloud frames.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-3DPointCloudObjectTracking`
    ///
    /// **3D Point Cloud Semantic Segmentation** - Use this task type when you want
    /// workers to create a point-level semantic segmentation masks by painting
    /// objects in a 3D point cloud using different colors where each color is
    /// assigned to one of the classes you specify.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-3DPointCloudSemanticSegmentation`
    ///
    /// **Use the following ARNs for Label Verification and Adjustment Jobs**
    ///
    /// Use label verification and adjustment jobs to review and adjust labels. To
    /// learn more, see [Verify and Adjust Labels
    /// ](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-verification-data.html).
    ///
    /// **Bounding box verification** - Uses a variant of the Expectation
    /// Maximization approach to estimate the true class of verification judgement
    /// for bounding box labels based on annotations from individual workers.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-VerificationBoundingBox`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-VerificationBoundingBox`
    ///
    /// **Bounding box adjustment** - Finds the most similar boxes from different
    /// workers based on the Jaccard index of the adjusted annotations.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-AdjustmentBoundingBox`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-AdjustmentBoundingBox`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-AdjustmentBoundingBox`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-AdjustmentBoundingBox`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-AdjustmentBoundingBox`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-AdjustmentBoundingBox`
    ///
    /// **Semantic segmentation verification** - Uses a variant of the Expectation
    /// Maximization approach to estimate the true class of verification judgment
    /// for semantic segmentation labels based on annotations from individual
    /// workers.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-VerificationSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-VerificationSemanticSegmentation`
    ///
    /// **Semantic segmentation adjustment** - Treats each pixel in an image as a
    /// multi-class classification and treats pixel adjusted annotations from
    /// workers as "votes" for the correct label.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-AdjustmentSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-AdjustmentSemanticSegmentation`
    ///
    /// **Video Frame Object Detection Adjustment** - Use this task type when you
    /// want workers to adjust bounding boxes that workers have added to video
    /// frames to classify and localize objects in a sequence of video frames.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-AdjustmentVideoObjectDetection`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-AdjustmentVideoObjectDetection`
    ///
    /// **Video Frame Object Tracking Adjustment** - Use this task type when you
    /// want workers to adjust bounding boxes that workers have added to video
    /// frames to track object movement across a sequence of video frames.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-AdjustmentVideoObjectTracking`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-AdjustmentVideoObjectTracking`
    ///
    /// **3D point cloud object detection adjustment** - Adjust 3D cuboids in a
    /// point cloud frame.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-Adjustment3DPointCloudObjectDetection`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-Adjustment3DPointCloudObjectDetection`
    ///
    /// **3D point cloud object tracking adjustment** - Adjust 3D cuboids across a
    /// sequence of point cloud frames.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-Adjustment3DPointCloudObjectTracking`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-Adjustment3DPointCloudObjectTracking`
    ///
    /// **3D point cloud semantic segmentation adjustment** - Adjust semantic
    /// segmentation masks in a 3D point cloud.
    ///
    /// *
    ///   `arn:aws:lambda:us-east-1:432418664414:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-east-2:266458841044:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:us-west-2:081040173940:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-1:568282634449:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-south-1:565803892007:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-central-1:203001061592:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:eu-west-2:487402164563:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    /// *
    ///   `arn:aws:lambda:ca-central-1:918755190332:function:PRE-Adjustment3DPointCloudSemanticSegmentation`
    ///
    /// **Generative AI/Custom** - Direct passthrough of input data without any
    /// transformation.
    ///
    /// * `arn:aws:lambda:us-east-1:432418664414:function:PRE-PassThrough`
    /// * `arn:aws:lambda:us-east-2:266458841044:function:PRE-PassThrough`
    /// * `arn:aws:lambda:us-west-2:081040173940:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ca-central-1:918755190332:function:PRE-PassThrough`
    /// * `arn:aws:lambda:eu-west-1:568282634449:function:PRE-PassThrough`
    /// * `arn:aws:lambda:eu-west-2:487402164563:function:PRE-PassThrough`
    /// * `arn:aws:lambda:eu-central-1:203001061592:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ap-northeast-1:477331159723:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ap-northeast-2:845288260483:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ap-south-1:565803892007:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ap-southeast-1:377565633583:function:PRE-PassThrough`
    /// * `arn:aws:lambda:ap-southeast-2:454466003867:function:PRE-PassThrough`
    pre_human_task_lambda_arn: ?[]const u8,

    /// The price that you pay for each task performed by an Amazon Mechanical Turk
    /// worker.
    public_workforce_task_price: ?PublicWorkforceTaskPrice,

    /// The length of time that a task remains available for labeling by human
    /// workers. The default and maximum values for this parameter depend on the
    /// type of workforce you use.
    ///
    /// * If you choose the Amazon Mechanical Turk workforce, the maximum is 12
    ///   hours (43,200 seconds). The default is 6 hours (21,600 seconds).
    /// * If you choose a private or vendor workforce, the default value is 30 days
    ///   (2592,000 seconds) for non-AL mode. For most users, the maximum is also 30
    ///   days.
    task_availability_lifetime_in_seconds: ?i32,

    /// A description of the task for your human workers.
    task_description: []const u8,

    /// Keywords used to describe the task so that workers on Amazon Mechanical Turk
    /// can discover the task.
    task_keywords: ?[]const []const u8,

    /// The amount of time that a worker has to complete a task.
    ///
    /// If you create a custom labeling job, the maximum value for this parameter is
    /// 8 hours (28,800 seconds).
    ///
    /// If you create a labeling job using a [built-in task
    /// type](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-task-types.html)
    /// the maximum for this parameter depends on the task type you use:
    ///
    /// * For
    ///   [image](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-label-images.html) and [text](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-label-text.html) labeling jobs, the maximum is 8 hours (28,800 seconds).
    /// * For [3D point
    ///   cloud](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-point-cloud.html) and [video frame](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-video.html) labeling jobs, the maximum is 30 days (2952,000 seconds) for non-AL mode. For most users, the maximum is also 30 days.
    task_time_limit_in_seconds: i32,

    /// A title for the task for your human workers.
    task_title: []const u8,

    /// Information about the user interface that workers use to complete the
    /// labeling task.
    ui_config: UiConfig,

    /// The Amazon Resource Name (ARN) of the work team assigned to complete the
    /// tasks.
    workteam_arn: []const u8,

    pub const json_field_names = .{
        .annotation_consolidation_config = "AnnotationConsolidationConfig",
        .max_concurrent_task_count = "MaxConcurrentTaskCount",
        .number_of_human_workers_per_data_object = "NumberOfHumanWorkersPerDataObject",
        .pre_human_task_lambda_arn = "PreHumanTaskLambdaArn",
        .public_workforce_task_price = "PublicWorkforceTaskPrice",
        .task_availability_lifetime_in_seconds = "TaskAvailabilityLifetimeInSeconds",
        .task_description = "TaskDescription",
        .task_keywords = "TaskKeywords",
        .task_time_limit_in_seconds = "TaskTimeLimitInSeconds",
        .task_title = "TaskTitle",
        .ui_config = "UiConfig",
        .workteam_arn = "WorkteamArn",
    };
};
