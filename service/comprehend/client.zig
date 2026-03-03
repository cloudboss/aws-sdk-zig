const aws = @import("aws");
const std = @import("std");

const batch_detect_dominant_language = @import("batch_detect_dominant_language.zig");
const batch_detect_entities = @import("batch_detect_entities.zig");
const batch_detect_key_phrases = @import("batch_detect_key_phrases.zig");
const batch_detect_sentiment = @import("batch_detect_sentiment.zig");
const batch_detect_syntax = @import("batch_detect_syntax.zig");
const batch_detect_targeted_sentiment = @import("batch_detect_targeted_sentiment.zig");
const classify_document = @import("classify_document.zig");
const contains_pii_entities = @import("contains_pii_entities.zig");
const create_dataset = @import("create_dataset.zig");
const create_document_classifier = @import("create_document_classifier.zig");
const create_endpoint = @import("create_endpoint.zig");
const create_entity_recognizer = @import("create_entity_recognizer.zig");
const create_flywheel = @import("create_flywheel.zig");
const delete_document_classifier = @import("delete_document_classifier.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const delete_entity_recognizer = @import("delete_entity_recognizer.zig");
const delete_flywheel = @import("delete_flywheel.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const describe_dataset = @import("describe_dataset.zig");
const describe_document_classification_job = @import("describe_document_classification_job.zig");
const describe_document_classifier = @import("describe_document_classifier.zig");
const describe_dominant_language_detection_job = @import("describe_dominant_language_detection_job.zig");
const describe_endpoint = @import("describe_endpoint.zig");
const describe_entities_detection_job = @import("describe_entities_detection_job.zig");
const describe_entity_recognizer = @import("describe_entity_recognizer.zig");
const describe_events_detection_job = @import("describe_events_detection_job.zig");
const describe_flywheel = @import("describe_flywheel.zig");
const describe_flywheel_iteration = @import("describe_flywheel_iteration.zig");
const describe_key_phrases_detection_job = @import("describe_key_phrases_detection_job.zig");
const describe_pii_entities_detection_job = @import("describe_pii_entities_detection_job.zig");
const describe_resource_policy = @import("describe_resource_policy.zig");
const describe_sentiment_detection_job = @import("describe_sentiment_detection_job.zig");
const describe_targeted_sentiment_detection_job = @import("describe_targeted_sentiment_detection_job.zig");
const describe_topics_detection_job = @import("describe_topics_detection_job.zig");
const detect_dominant_language = @import("detect_dominant_language.zig");
const detect_entities = @import("detect_entities.zig");
const detect_key_phrases = @import("detect_key_phrases.zig");
const detect_pii_entities = @import("detect_pii_entities.zig");
const detect_sentiment = @import("detect_sentiment.zig");
const detect_syntax = @import("detect_syntax.zig");
const detect_targeted_sentiment = @import("detect_targeted_sentiment.zig");
const detect_toxic_content = @import("detect_toxic_content.zig");
const import_model = @import("import_model.zig");
const list_datasets = @import("list_datasets.zig");
const list_document_classification_jobs = @import("list_document_classification_jobs.zig");
const list_document_classifier_summaries = @import("list_document_classifier_summaries.zig");
const list_document_classifiers = @import("list_document_classifiers.zig");
const list_dominant_language_detection_jobs = @import("list_dominant_language_detection_jobs.zig");
const list_endpoints = @import("list_endpoints.zig");
const list_entities_detection_jobs = @import("list_entities_detection_jobs.zig");
const list_entity_recognizer_summaries = @import("list_entity_recognizer_summaries.zig");
const list_entity_recognizers = @import("list_entity_recognizers.zig");
const list_events_detection_jobs = @import("list_events_detection_jobs.zig");
const list_flywheel_iteration_history = @import("list_flywheel_iteration_history.zig");
const list_flywheels = @import("list_flywheels.zig");
const list_key_phrases_detection_jobs = @import("list_key_phrases_detection_jobs.zig");
const list_pii_entities_detection_jobs = @import("list_pii_entities_detection_jobs.zig");
const list_sentiment_detection_jobs = @import("list_sentiment_detection_jobs.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_targeted_sentiment_detection_jobs = @import("list_targeted_sentiment_detection_jobs.zig");
const list_topics_detection_jobs = @import("list_topics_detection_jobs.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const start_document_classification_job = @import("start_document_classification_job.zig");
const start_dominant_language_detection_job = @import("start_dominant_language_detection_job.zig");
const start_entities_detection_job = @import("start_entities_detection_job.zig");
const start_events_detection_job = @import("start_events_detection_job.zig");
const start_flywheel_iteration = @import("start_flywheel_iteration.zig");
const start_key_phrases_detection_job = @import("start_key_phrases_detection_job.zig");
const start_pii_entities_detection_job = @import("start_pii_entities_detection_job.zig");
const start_sentiment_detection_job = @import("start_sentiment_detection_job.zig");
const start_targeted_sentiment_detection_job = @import("start_targeted_sentiment_detection_job.zig");
const start_topics_detection_job = @import("start_topics_detection_job.zig");
const stop_dominant_language_detection_job = @import("stop_dominant_language_detection_job.zig");
const stop_entities_detection_job = @import("stop_entities_detection_job.zig");
const stop_events_detection_job = @import("stop_events_detection_job.zig");
const stop_key_phrases_detection_job = @import("stop_key_phrases_detection_job.zig");
const stop_pii_entities_detection_job = @import("stop_pii_entities_detection_job.zig");
const stop_sentiment_detection_job = @import("stop_sentiment_detection_job.zig");
const stop_targeted_sentiment_detection_job = @import("stop_targeted_sentiment_detection_job.zig");
const stop_training_document_classifier = @import("stop_training_document_classifier.zig");
const stop_training_entity_recognizer = @import("stop_training_entity_recognizer.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_endpoint = @import("update_endpoint.zig");
const update_flywheel = @import("update_flywheel.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Comprehend";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Determines the dominant language of the input text for a batch of documents.
    /// For a list
    /// of languages that Amazon Comprehend can detect, see [Amazon Comprehend
    /// Supported
    /// Languages](https://docs.aws.amazon.com/comprehend/latest/dg/how-languages.html).
    pub fn batchDetectDominantLanguage(self: *Self, allocator: std.mem.Allocator, input: batch_detect_dominant_language.BatchDetectDominantLanguageInput, options: batch_detect_dominant_language.Options) !batch_detect_dominant_language.BatchDetectDominantLanguageOutput {
        return batch_detect_dominant_language.execute(self, allocator, input, options);
    }

    /// Inspects the text of a batch of documents for named entities and returns
    /// information
    /// about them. For more information about named entities, see
    /// [Entities](https://docs.aws.amazon.com/comprehend/latest/dg/how-entities.html) in the Comprehend Developer Guide.
    pub fn batchDetectEntities(self: *Self, allocator: std.mem.Allocator, input: batch_detect_entities.BatchDetectEntitiesInput, options: batch_detect_entities.Options) !batch_detect_entities.BatchDetectEntitiesOutput {
        return batch_detect_entities.execute(self, allocator, input, options);
    }

    /// Detects the key noun phrases found in a batch of documents.
    pub fn batchDetectKeyPhrases(self: *Self, allocator: std.mem.Allocator, input: batch_detect_key_phrases.BatchDetectKeyPhrasesInput, options: batch_detect_key_phrases.Options) !batch_detect_key_phrases.BatchDetectKeyPhrasesOutput {
        return batch_detect_key_phrases.execute(self, allocator, input, options);
    }

    /// Inspects a batch of documents and returns an inference of the prevailing
    /// sentiment,
    /// `POSITIVE`, `NEUTRAL`, `MIXED`, or `NEGATIVE`,
    /// in each one.
    pub fn batchDetectSentiment(self: *Self, allocator: std.mem.Allocator, input: batch_detect_sentiment.BatchDetectSentimentInput, options: batch_detect_sentiment.Options) !batch_detect_sentiment.BatchDetectSentimentOutput {
        return batch_detect_sentiment.execute(self, allocator, input, options);
    }

    /// Inspects the text of a batch of documents for the syntax and part of speech
    /// of the words
    /// in the document and returns information about them. For more information,
    /// see
    /// [Syntax](https://docs.aws.amazon.com/comprehend/latest/dg/how-syntax.html)
    /// in the Comprehend Developer Guide.
    pub fn batchDetectSyntax(self: *Self, allocator: std.mem.Allocator, input: batch_detect_syntax.BatchDetectSyntaxInput, options: batch_detect_syntax.Options) !batch_detect_syntax.BatchDetectSyntaxOutput {
        return batch_detect_syntax.execute(self, allocator, input, options);
    }

    /// Inspects a batch of documents and returns a sentiment analysis
    /// for each entity identified in the documents.
    ///
    /// For more information about targeted sentiment, see [Targeted
    /// sentiment](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html) in the *Amazon Comprehend Developer Guide*.
    pub fn batchDetectTargetedSentiment(self: *Self, allocator: std.mem.Allocator, input: batch_detect_targeted_sentiment.BatchDetectTargetedSentimentInput, options: batch_detect_targeted_sentiment.Options) !batch_detect_targeted_sentiment.BatchDetectTargetedSentimentOutput {
        return batch_detect_targeted_sentiment.execute(self, allocator, input, options);
    }

    /// Creates a classification request to analyze a single document in real-time.
    /// `ClassifyDocument`
    /// supports the following model types:
    ///
    /// * Custom classifier - a custom model that you have created and trained.
    /// For input, you can provide plain text, a single-page document (PDF, Word, or
    /// image), or
    /// Amazon Textract API output. For more information, see [Custom
    /// classification](https://docs.aws.amazon.com/comprehend/latest/dg/how-document-classification.html) in the *Amazon Comprehend Developer Guide*.
    ///
    /// * Prompt safety classifier - Amazon Comprehend provides a pre-trained model
    ///   for classifying
    /// input prompts for generative AI applications.
    /// For input, you provide English plain text input.
    /// For prompt safety classification, the response includes only the `Classes`
    /// field.
    /// For more information about prompt safety classifiers, see [Prompt safety
    /// classification](https://docs.aws.amazon.com/comprehend/latest/dg/trust-safety.html#prompt-classification) in the *Amazon Comprehend Developer Guide*.
    ///
    /// If the system detects errors while processing a page in the input document,
    /// the API response includes an `Errors` field that describes the errors.
    ///
    /// If the system detects a document-level error in your input document, the API
    /// returns an
    /// `InvalidRequestException` error response.
    /// For details about this exception, see
    /// [
    /// Errors in semi-structured
    /// documents](https://docs.aws.amazon.com/comprehend/latest/dg/idp-inputs-sync-err.html) in the Comprehend Developer Guide.
    pub fn classifyDocument(self: *Self, allocator: std.mem.Allocator, input: classify_document.ClassifyDocumentInput, options: classify_document.Options) !classify_document.ClassifyDocumentOutput {
        return classify_document.execute(self, allocator, input, options);
    }

    /// Analyzes input text for the presence of personally identifiable information
    /// (PII) and
    /// returns the labels of identified PII entity types such as name, address,
    /// bank account number,
    /// or phone number.
    pub fn containsPiiEntities(self: *Self, allocator: std.mem.Allocator, input: contains_pii_entities.ContainsPiiEntitiesInput, options: contains_pii_entities.Options) !contains_pii_entities.ContainsPiiEntitiesOutput {
        return contains_pii_entities.execute(self, allocator, input, options);
    }

    /// Creates a dataset to upload training or test data for a model associated
    /// with a flywheel.
    /// For more information about datasets, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn createDataset(self: *Self, allocator: std.mem.Allocator, input: create_dataset.CreateDatasetInput, options: create_dataset.Options) !create_dataset.CreateDatasetOutput {
        return create_dataset.execute(self, allocator, input, options);
    }

    /// Creates a new document classifier that you can use to categorize documents.
    /// To create a
    /// classifier, you provide a set of training documents that are labeled with
    /// the categories that you
    /// want to use. For more information, see
    /// [Training classifier
    /// models](https://docs.aws.amazon.com/comprehend/latest/dg/training-classifier-model.html)
    /// in the Comprehend Developer Guide.
    pub fn createDocumentClassifier(self: *Self, allocator: std.mem.Allocator, input: create_document_classifier.CreateDocumentClassifierInput, options: create_document_classifier.Options) !create_document_classifier.CreateDocumentClassifierOutput {
        return create_document_classifier.execute(self, allocator, input, options);
    }

    /// Creates a model-specific endpoint for synchronous inference for a previously
    /// trained
    /// custom model
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    pub fn createEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_endpoint.CreateEndpointInput, options: create_endpoint.Options) !create_endpoint.CreateEndpointOutput {
        return create_endpoint.execute(self, allocator, input, options);
    }

    /// Creates an entity recognizer using submitted files. After your
    /// `CreateEntityRecognizer` request is submitted, you can check job status
    /// using the
    /// `DescribeEntityRecognizer` API.
    pub fn createEntityRecognizer(self: *Self, allocator: std.mem.Allocator, input: create_entity_recognizer.CreateEntityRecognizerInput, options: create_entity_recognizer.Options) !create_entity_recognizer.CreateEntityRecognizerOutput {
        return create_entity_recognizer.execute(self, allocator, input, options);
    }

    /// A flywheel is an Amazon Web Services resource that orchestrates the ongoing
    /// training of a model for custom classification
    /// or custom entity recognition. You can create a flywheel to start with an
    /// existing trained model, or
    /// Comprehend can create and train a new model.
    ///
    /// When you create the flywheel, Comprehend creates a data lake in your
    /// account. The data lake holds the training
    /// data and test data for all versions of the model.
    ///
    /// To use a flywheel with an existing trained model, you specify the active
    /// model version. Comprehend copies the model's
    /// training data and test data into the flywheel's data lake.
    ///
    /// To use the flywheel with a new model, you need to provide a dataset for
    /// training data (and optional test data)
    /// when you create the flywheel.
    ///
    /// For more information about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn createFlywheel(self: *Self, allocator: std.mem.Allocator, input: create_flywheel.CreateFlywheelInput, options: create_flywheel.Options) !create_flywheel.CreateFlywheelOutput {
        return create_flywheel.execute(self, allocator, input, options);
    }

    /// Deletes a previously created document classifier
    ///
    /// Only those classifiers that are in terminated states (IN_ERROR, TRAINED)
    /// will be deleted.
    /// If an active inference job is using the model, a `ResourceInUseException`
    /// will be
    /// returned.
    ///
    /// This is an asynchronous action that puts the classifier into a DELETING
    /// state, and it is
    /// then removed by a background job. Once removed, the classifier disappears
    /// from your account
    /// and is no longer available for use.
    pub fn deleteDocumentClassifier(self: *Self, allocator: std.mem.Allocator, input: delete_document_classifier.DeleteDocumentClassifierInput, options: delete_document_classifier.Options) !delete_document_classifier.DeleteDocumentClassifierOutput {
        return delete_document_classifier.execute(self, allocator, input, options);
    }

    /// Deletes a model-specific endpoint for a previously-trained custom model. All
    /// endpoints
    /// must be deleted in order for the model to be deleted.
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an entity recognizer.
    ///
    /// Only those recognizers that are in terminated states (IN_ERROR, TRAINED)
    /// will be deleted.
    /// If an active inference job is using the model, a `ResourceInUseException`
    /// will be
    /// returned.
    ///
    /// This is an asynchronous action that puts the recognizer into a DELETING
    /// state, and it is
    /// then removed by a background job. Once removed, the recognizer disappears
    /// from your account
    /// and is no longer available for use.
    pub fn deleteEntityRecognizer(self: *Self, allocator: std.mem.Allocator, input: delete_entity_recognizer.DeleteEntityRecognizerInput, options: delete_entity_recognizer.Options) !delete_entity_recognizer.DeleteEntityRecognizerOutput {
        return delete_entity_recognizer.execute(self, allocator, input, options);
    }

    /// Deletes a flywheel. When you delete the flywheel, Amazon Comprehend
    /// does not delete the data lake or the model associated with the flywheel.
    ///
    /// For more information about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn deleteFlywheel(self: *Self, allocator: std.mem.Allocator, input: delete_flywheel.DeleteFlywheelInput, options: delete_flywheel.Options) !delete_flywheel.DeleteFlywheelOutput {
        return delete_flywheel.execute(self, allocator, input, options);
    }

    /// Deletes a resource-based policy that is attached to a custom model.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns information about the dataset that you specify.
    /// For more information about datasets, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn describeDataset(self: *Self, allocator: std.mem.Allocator, input: describe_dataset.DescribeDatasetInput, options: describe_dataset.Options) !describe_dataset.DescribeDatasetOutput {
        return describe_dataset.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a document classification job. Use this
    /// operation to
    /// get the status of a classification job.
    pub fn describeDocumentClassificationJob(self: *Self, allocator: std.mem.Allocator, input: describe_document_classification_job.DescribeDocumentClassificationJobInput, options: describe_document_classification_job.Options) !describe_document_classification_job.DescribeDocumentClassificationJobOutput {
        return describe_document_classification_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a document classifier.
    pub fn describeDocumentClassifier(self: *Self, allocator: std.mem.Allocator, input: describe_document_classifier.DescribeDocumentClassifierInput, options: describe_document_classifier.Options) !describe_document_classifier.DescribeDocumentClassifierOutput {
        return describe_document_classifier.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a dominant language detection job. Use
    /// this operation
    /// to get the status of a detection job.
    pub fn describeDominantLanguageDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_dominant_language_detection_job.DescribeDominantLanguageDetectionJobInput, options: describe_dominant_language_detection_job.Options) !describe_dominant_language_detection_job.DescribeDominantLanguageDetectionJobOutput {
        return describe_dominant_language_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a specific endpoint. Use this operation
    /// to get the
    /// status of an endpoint.
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    pub fn describeEndpoint(self: *Self, allocator: std.mem.Allocator, input: describe_endpoint.DescribeEndpointInput, options: describe_endpoint.Options) !describe_endpoint.DescribeEndpointOutput {
        return describe_endpoint.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with an entities detection job. Use this
    /// operation to get
    /// the status of a detection job.
    pub fn describeEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_entities_detection_job.DescribeEntitiesDetectionJobInput, options: describe_entities_detection_job.Options) !describe_entities_detection_job.DescribeEntitiesDetectionJobOutput {
        return describe_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Provides details about an entity recognizer including status, S3 buckets
    /// containing
    /// training data, recognizer metadata, metrics, and so on.
    pub fn describeEntityRecognizer(self: *Self, allocator: std.mem.Allocator, input: describe_entity_recognizer.DescribeEntityRecognizerInput, options: describe_entity_recognizer.Options) !describe_entity_recognizer.DescribeEntityRecognizerOutput {
        return describe_entity_recognizer.execute(self, allocator, input, options);
    }

    /// Gets the status and details of an events detection job.
    pub fn describeEventsDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_events_detection_job.DescribeEventsDetectionJobInput, options: describe_events_detection_job.Options) !describe_events_detection_job.DescribeEventsDetectionJobOutput {
        return describe_events_detection_job.execute(self, allocator, input, options);
    }

    /// Provides configuration information about the flywheel. For more information
    /// about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn describeFlywheel(self: *Self, allocator: std.mem.Allocator, input: describe_flywheel.DescribeFlywheelInput, options: describe_flywheel.Options) !describe_flywheel.DescribeFlywheelOutput {
        return describe_flywheel.execute(self, allocator, input, options);
    }

    /// Retrieve the configuration properties of a flywheel iteration.
    /// For more information about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn describeFlywheelIteration(self: *Self, allocator: std.mem.Allocator, input: describe_flywheel_iteration.DescribeFlywheelIterationInput, options: describe_flywheel_iteration.Options) !describe_flywheel_iteration.DescribeFlywheelIterationOutput {
        return describe_flywheel_iteration.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a key phrases detection job. Use this
    /// operation to get
    /// the status of a detection job.
    pub fn describeKeyPhrasesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_key_phrases_detection_job.DescribeKeyPhrasesDetectionJobInput, options: describe_key_phrases_detection_job.Options) !describe_key_phrases_detection_job.DescribeKeyPhrasesDetectionJobOutput {
        return describe_key_phrases_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a PII entities detection job. For
    /// example, you can use
    /// this operation to get the job status.
    pub fn describePiiEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_pii_entities_detection_job.DescribePiiEntitiesDetectionJobInput, options: describe_pii_entities_detection_job.Options) !describe_pii_entities_detection_job.DescribePiiEntitiesDetectionJobOutput {
        return describe_pii_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the details of a resource-based policy that is attached to a custom
    /// model, including
    /// the JSON body of the policy.
    pub fn describeResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: describe_resource_policy.DescribeResourcePolicyInput, options: describe_resource_policy.Options) !describe_resource_policy.DescribeResourcePolicyOutput {
        return describe_resource_policy.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a sentiment detection job. Use this
    /// operation to get
    /// the status of a detection job.
    pub fn describeSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_sentiment_detection_job.DescribeSentimentDetectionJobInput, options: describe_sentiment_detection_job.Options) !describe_sentiment_detection_job.DescribeSentimentDetectionJobOutput {
        return describe_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a targeted sentiment detection job. Use
    /// this operation
    /// to get the status of the job.
    pub fn describeTargetedSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_targeted_sentiment_detection_job.DescribeTargetedSentimentDetectionJobInput, options: describe_targeted_sentiment_detection_job.Options) !describe_targeted_sentiment_detection_job.DescribeTargetedSentimentDetectionJobOutput {
        return describe_targeted_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Gets the properties associated with a topic detection job. Use this
    /// operation to get
    /// the status of a detection job.
    pub fn describeTopicsDetectionJob(self: *Self, allocator: std.mem.Allocator, input: describe_topics_detection_job.DescribeTopicsDetectionJobInput, options: describe_topics_detection_job.Options) !describe_topics_detection_job.DescribeTopicsDetectionJobOutput {
        return describe_topics_detection_job.execute(self, allocator, input, options);
    }

    /// Determines the dominant language of the input text. For a list of languages
    /// that Amazon
    /// Comprehend can detect, see [Amazon Comprehend Supported
    /// Languages](https://docs.aws.amazon.com/comprehend/latest/dg/how-languages.html).
    pub fn detectDominantLanguage(self: *Self, allocator: std.mem.Allocator, input: detect_dominant_language.DetectDominantLanguageInput, options: detect_dominant_language.Options) !detect_dominant_language.DetectDominantLanguageOutput {
        return detect_dominant_language.execute(self, allocator, input, options);
    }

    /// Detects named entities in input text when you use the pre-trained model.
    /// Detects custom entities if you have a custom entity recognition model.
    ///
    /// When detecting named entities using the pre-trained model, use plain text as
    /// the input.
    /// For more information about named entities, see
    /// [Entities](https://docs.aws.amazon.com/comprehend/latest/dg/how-entities.html) in the Comprehend Developer Guide.
    ///
    /// When you use a custom entity recognition model,
    /// you can input plain text or you can upload a single-page input document
    /// (text, PDF, Word, or image).
    ///
    /// If the system detects errors while processing a page in the input document,
    /// the API response
    /// includes an entry in `Errors` for each error.
    ///
    /// If the system detects a document-level error in your input document, the API
    /// returns an
    /// `InvalidRequestException` error response.
    /// For details about this exception, see
    /// [
    /// Errors in semi-structured
    /// documents](https://docs.aws.amazon.com/comprehend/latest/dg/idp-inputs-sync-err.html) in the Comprehend Developer Guide.
    pub fn detectEntities(self: *Self, allocator: std.mem.Allocator, input: detect_entities.DetectEntitiesInput, options: detect_entities.Options) !detect_entities.DetectEntitiesOutput {
        return detect_entities.execute(self, allocator, input, options);
    }

    /// Detects the key noun phrases found in the text.
    pub fn detectKeyPhrases(self: *Self, allocator: std.mem.Allocator, input: detect_key_phrases.DetectKeyPhrasesInput, options: detect_key_phrases.Options) !detect_key_phrases.DetectKeyPhrasesOutput {
        return detect_key_phrases.execute(self, allocator, input, options);
    }

    /// Inspects the input text for entities that contain personally identifiable
    /// information
    /// (PII) and returns information about them.
    pub fn detectPiiEntities(self: *Self, allocator: std.mem.Allocator, input: detect_pii_entities.DetectPiiEntitiesInput, options: detect_pii_entities.Options) !detect_pii_entities.DetectPiiEntitiesOutput {
        return detect_pii_entities.execute(self, allocator, input, options);
    }

    /// Inspects text and returns an inference of the prevailing sentiment
    /// (`POSITIVE`, `NEUTRAL`, `MIXED`, or `NEGATIVE`).
    pub fn detectSentiment(self: *Self, allocator: std.mem.Allocator, input: detect_sentiment.DetectSentimentInput, options: detect_sentiment.Options) !detect_sentiment.DetectSentimentOutput {
        return detect_sentiment.execute(self, allocator, input, options);
    }

    /// Inspects text for syntax and the part of speech of words in the document.
    /// For more
    /// information, see
    /// [Syntax](https://docs.aws.amazon.com/comprehend/latest/dg/how-syntax.html)
    /// in the Comprehend Developer Guide.
    pub fn detectSyntax(self: *Self, allocator: std.mem.Allocator, input: detect_syntax.DetectSyntaxInput, options: detect_syntax.Options) !detect_syntax.DetectSyntaxOutput {
        return detect_syntax.execute(self, allocator, input, options);
    }

    /// Inspects the input text and returns a sentiment analysis for each entity
    /// identified in the text.
    ///
    /// For more information about targeted sentiment, see [Targeted
    /// sentiment](https://docs.aws.amazon.com/comprehend/latest/dg/how-targeted-sentiment.html) in the *Amazon Comprehend Developer Guide*.
    pub fn detectTargetedSentiment(self: *Self, allocator: std.mem.Allocator, input: detect_targeted_sentiment.DetectTargetedSentimentInput, options: detect_targeted_sentiment.Options) !detect_targeted_sentiment.DetectTargetedSentimentOutput {
        return detect_targeted_sentiment.execute(self, allocator, input, options);
    }

    /// Performs toxicity analysis on the list of text strings that you provide as
    /// input.
    /// The API response contains a results list that matches the size of the input
    /// list.
    /// For more information about toxicity detection, see [Toxicity
    /// detection](https://docs.aws.amazon.com/comprehend/latest/dg/toxicity-detection.html) in the *Amazon Comprehend Developer Guide*.
    pub fn detectToxicContent(self: *Self, allocator: std.mem.Allocator, input: detect_toxic_content.DetectToxicContentInput, options: detect_toxic_content.Options) !detect_toxic_content.DetectToxicContentOutput {
        return detect_toxic_content.execute(self, allocator, input, options);
    }

    /// Creates a new custom model that replicates a source custom model that you
    /// import. The
    /// source model can be in your Amazon Web Services account or another one.
    ///
    /// If the source model is in another Amazon Web Services account, then it must
    /// have a resource-based policy
    /// that authorizes you to import it.
    ///
    /// The source model must be in the same Amazon Web Services Region that you're
    /// using when you import. You
    /// can't import a model that's in a different Region.
    pub fn importModel(self: *Self, allocator: std.mem.Allocator, input: import_model.ImportModelInput, options: import_model.Options) !import_model.ImportModelOutput {
        return import_model.execute(self, allocator, input, options);
    }

    /// List the datasets that you have configured in this Region. For more
    /// information about datasets, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn listDatasets(self: *Self, allocator: std.mem.Allocator, input: list_datasets.ListDatasetsInput, options: list_datasets.Options) !list_datasets.ListDatasetsOutput {
        return list_datasets.execute(self, allocator, input, options);
    }

    /// Gets a list of the documentation classification jobs that you have
    /// submitted.
    pub fn listDocumentClassificationJobs(self: *Self, allocator: std.mem.Allocator, input: list_document_classification_jobs.ListDocumentClassificationJobsInput, options: list_document_classification_jobs.Options) !list_document_classification_jobs.ListDocumentClassificationJobsOutput {
        return list_document_classification_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of summaries of the document classifiers that you have created
    pub fn listDocumentClassifierSummaries(self: *Self, allocator: std.mem.Allocator, input: list_document_classifier_summaries.ListDocumentClassifierSummariesInput, options: list_document_classifier_summaries.Options) !list_document_classifier_summaries.ListDocumentClassifierSummariesOutput {
        return list_document_classifier_summaries.execute(self, allocator, input, options);
    }

    /// Gets a list of the document classifiers that you have created.
    pub fn listDocumentClassifiers(self: *Self, allocator: std.mem.Allocator, input: list_document_classifiers.ListDocumentClassifiersInput, options: list_document_classifiers.Options) !list_document_classifiers.ListDocumentClassifiersOutput {
        return list_document_classifiers.execute(self, allocator, input, options);
    }

    /// Gets a list of the dominant language detection jobs that you have submitted.
    pub fn listDominantLanguageDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_dominant_language_detection_jobs.ListDominantLanguageDetectionJobsInput, options: list_dominant_language_detection_jobs.Options) !list_dominant_language_detection_jobs.ListDominantLanguageDetectionJobsOutput {
        return list_dominant_language_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of all existing endpoints that you've created.
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    pub fn listEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_endpoints.ListEndpointsInput, options: list_endpoints.Options) !list_endpoints.ListEndpointsOutput {
        return list_endpoints.execute(self, allocator, input, options);
    }

    /// Gets a list of the entity detection jobs that you have submitted.
    pub fn listEntitiesDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_entities_detection_jobs.ListEntitiesDetectionJobsInput, options: list_entities_detection_jobs.Options) !list_entities_detection_jobs.ListEntitiesDetectionJobsOutput {
        return list_entities_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of summaries for the entity recognizers that you have created.
    pub fn listEntityRecognizerSummaries(self: *Self, allocator: std.mem.Allocator, input: list_entity_recognizer_summaries.ListEntityRecognizerSummariesInput, options: list_entity_recognizer_summaries.Options) !list_entity_recognizer_summaries.ListEntityRecognizerSummariesOutput {
        return list_entity_recognizer_summaries.execute(self, allocator, input, options);
    }

    /// Gets a list of the properties of all entity recognizers that you created,
    /// including
    /// recognizers currently in training. Allows you to filter the list of
    /// recognizers based on
    /// criteria such as status and submission time. This call returns up to 500
    /// entity recognizers in
    /// the list, with a default number of 100 recognizers in the list.
    ///
    /// The results of this list are not in any particular order. Please get the
    /// list and sort
    /// locally if needed.
    pub fn listEntityRecognizers(self: *Self, allocator: std.mem.Allocator, input: list_entity_recognizers.ListEntityRecognizersInput, options: list_entity_recognizers.Options) !list_entity_recognizers.ListEntityRecognizersOutput {
        return list_entity_recognizers.execute(self, allocator, input, options);
    }

    /// Gets a list of the events detection jobs that you have submitted.
    pub fn listEventsDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_events_detection_jobs.ListEventsDetectionJobsInput, options: list_events_detection_jobs.Options) !list_events_detection_jobs.ListEventsDetectionJobsOutput {
        return list_events_detection_jobs.execute(self, allocator, input, options);
    }

    /// Information about the history of a flywheel iteration.
    /// For more information about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn listFlywheelIterationHistory(self: *Self, allocator: std.mem.Allocator, input: list_flywheel_iteration_history.ListFlywheelIterationHistoryInput, options: list_flywheel_iteration_history.Options) !list_flywheel_iteration_history.ListFlywheelIterationHistoryOutput {
        return list_flywheel_iteration_history.execute(self, allocator, input, options);
    }

    /// Gets a list of the flywheels that you have created.
    pub fn listFlywheels(self: *Self, allocator: std.mem.Allocator, input: list_flywheels.ListFlywheelsInput, options: list_flywheels.Options) !list_flywheels.ListFlywheelsOutput {
        return list_flywheels.execute(self, allocator, input, options);
    }

    /// Get a list of key phrase detection jobs that you have submitted.
    pub fn listKeyPhrasesDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_key_phrases_detection_jobs.ListKeyPhrasesDetectionJobsInput, options: list_key_phrases_detection_jobs.Options) !list_key_phrases_detection_jobs.ListKeyPhrasesDetectionJobsOutput {
        return list_key_phrases_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of the PII entity detection jobs that you have submitted.
    pub fn listPiiEntitiesDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_pii_entities_detection_jobs.ListPiiEntitiesDetectionJobsInput, options: list_pii_entities_detection_jobs.Options) !list_pii_entities_detection_jobs.ListPiiEntitiesDetectionJobsOutput {
        return list_pii_entities_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of sentiment detection jobs that you have submitted.
    pub fn listSentimentDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_sentiment_detection_jobs.ListSentimentDetectionJobsInput, options: list_sentiment_detection_jobs.Options) !list_sentiment_detection_jobs.ListSentimentDetectionJobsOutput {
        return list_sentiment_detection_jobs.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a given Amazon Comprehend resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Gets a list of targeted sentiment detection jobs that you have submitted.
    pub fn listTargetedSentimentDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_targeted_sentiment_detection_jobs.ListTargetedSentimentDetectionJobsInput, options: list_targeted_sentiment_detection_jobs.Options) !list_targeted_sentiment_detection_jobs.ListTargetedSentimentDetectionJobsOutput {
        return list_targeted_sentiment_detection_jobs.execute(self, allocator, input, options);
    }

    /// Gets a list of the topic detection jobs that you have submitted.
    pub fn listTopicsDetectionJobs(self: *Self, allocator: std.mem.Allocator, input: list_topics_detection_jobs.ListTopicsDetectionJobsInput, options: list_topics_detection_jobs.Options) !list_topics_detection_jobs.ListTopicsDetectionJobsOutput {
        return list_topics_detection_jobs.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to a custom model. You can use this policy
    /// to authorize
    /// an entity in another Amazon Web Services account to import the custom model,
    /// which replicates it in Amazon
    /// Comprehend in their account.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous document classification job using a custom
    /// classification model. Use the
    /// `DescribeDocumentClassificationJob`
    /// operation to track the progress of the job.
    pub fn startDocumentClassificationJob(self: *Self, allocator: std.mem.Allocator, input: start_document_classification_job.StartDocumentClassificationJobInput, options: start_document_classification_job.Options) !start_document_classification_job.StartDocumentClassificationJobOutput {
        return start_document_classification_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous dominant language detection job for a collection of
    /// documents. Use
    /// the operation to track the status
    /// of a job.
    pub fn startDominantLanguageDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_dominant_language_detection_job.StartDominantLanguageDetectionJobInput, options: start_dominant_language_detection_job.Options) !start_dominant_language_detection_job.StartDominantLanguageDetectionJobOutput {
        return start_dominant_language_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous entity detection job for a collection of documents.
    /// Use the operation to track the status of a job.
    ///
    /// This API can be used for either standard entity detection or custom entity
    /// recognition. In
    /// order to be used for custom entity recognition, the optional
    /// `EntityRecognizerArn`
    /// must be used in order to provide access to the recognizer being used to
    /// detect the custom
    /// entity.
    pub fn startEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_entities_detection_job.StartEntitiesDetectionJobInput, options: start_entities_detection_job.Options) !start_entities_detection_job.StartEntitiesDetectionJobOutput {
        return start_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous event detection job for a collection of documents.
    pub fn startEventsDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_events_detection_job.StartEventsDetectionJobInput, options: start_events_detection_job.Options) !start_events_detection_job.StartEventsDetectionJobOutput {
        return start_events_detection_job.execute(self, allocator, input, options);
    }

    /// Start the flywheel iteration.This operation uses any new datasets to train a
    /// new model version.
    /// For more information about flywheels, see [
    /// Flywheel
    /// overview](https://docs.aws.amazon.com/comprehend/latest/dg/flywheels-about.html) in the *Amazon Comprehend Developer Guide*.
    pub fn startFlywheelIteration(self: *Self, allocator: std.mem.Allocator, input: start_flywheel_iteration.StartFlywheelIterationInput, options: start_flywheel_iteration.Options) !start_flywheel_iteration.StartFlywheelIterationOutput {
        return start_flywheel_iteration.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous key phrase detection job for a collection of
    /// documents. Use the
    /// operation to track the status of a
    /// job.
    pub fn startKeyPhrasesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_key_phrases_detection_job.StartKeyPhrasesDetectionJobInput, options: start_key_phrases_detection_job.Options) !start_key_phrases_detection_job.StartKeyPhrasesDetectionJobOutput {
        return start_key_phrases_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous PII entity detection job for a collection of
    /// documents.
    pub fn startPiiEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_pii_entities_detection_job.StartPiiEntitiesDetectionJobInput, options: start_pii_entities_detection_job.Options) !start_pii_entities_detection_job.StartPiiEntitiesDetectionJobOutput {
        return start_pii_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous sentiment detection job for a collection of
    /// documents. Use the
    /// operation to track the status of a
    /// job.
    pub fn startSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_sentiment_detection_job.StartSentimentDetectionJobInput, options: start_sentiment_detection_job.Options) !start_sentiment_detection_job.StartSentimentDetectionJobOutput {
        return start_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous targeted sentiment detection job for a collection of
    /// documents. Use the
    /// `DescribeTargetedSentimentDetectionJob` operation to track the status of a
    /// job.
    pub fn startTargetedSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_targeted_sentiment_detection_job.StartTargetedSentimentDetectionJobInput, options: start_targeted_sentiment_detection_job.Options) !start_targeted_sentiment_detection_job.StartTargetedSentimentDetectionJobOutput {
        return start_targeted_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Starts an asynchronous topic detection job. Use the
    /// `DescribeTopicDetectionJob` operation to track the status of a job.
    pub fn startTopicsDetectionJob(self: *Self, allocator: std.mem.Allocator, input: start_topics_detection_job.StartTopicsDetectionJobInput, options: start_topics_detection_job.Options) !start_topics_detection_job.StartTopicsDetectionJobOutput {
        return start_topics_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a dominant language detection job in progress.
    ///
    /// If the job state is `IN_PROGRESS` the job is marked for termination and put
    /// into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped, it
    /// is put into the `COMPLETED` state; otherwise the job is stopped and put into
    /// the
    /// `STOPPED` state.
    ///
    /// If the job is in the `COMPLETED` or `FAILED` state when you call the
    /// `StopDominantLanguageDetectionJob` operation, the operation returns a 400
    /// Internal Request Exception.
    ///
    /// When a job is stopped, any documents already processed are written to the
    /// output
    /// location.
    pub fn stopDominantLanguageDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_dominant_language_detection_job.StopDominantLanguageDetectionJobInput, options: stop_dominant_language_detection_job.Options) !stop_dominant_language_detection_job.StopDominantLanguageDetectionJobOutput {
        return stop_dominant_language_detection_job.execute(self, allocator, input, options);
    }

    /// Stops an entities detection job in progress.
    ///
    /// If the job state is `IN_PROGRESS` the job is marked for termination and put
    /// into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped, it
    /// is put into the `COMPLETED` state; otherwise the job is stopped and put into
    /// the
    /// `STOPPED` state.
    ///
    /// If the job is in the `COMPLETED` or `FAILED` state when you call the
    /// `StopDominantLanguageDetectionJob` operation, the operation returns a 400
    /// Internal Request Exception.
    ///
    /// When a job is stopped, any documents already processed are written to the
    /// output
    /// location.
    pub fn stopEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_entities_detection_job.StopEntitiesDetectionJobInput, options: stop_entities_detection_job.Options) !stop_entities_detection_job.StopEntitiesDetectionJobOutput {
        return stop_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Stops an events detection job in progress.
    pub fn stopEventsDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_events_detection_job.StopEventsDetectionJobInput, options: stop_events_detection_job.Options) !stop_events_detection_job.StopEventsDetectionJobOutput {
        return stop_events_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a key phrases detection job in progress.
    ///
    /// If the job state is `IN_PROGRESS` the job is marked for termination and put
    /// into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped, it
    /// is put into the `COMPLETED` state; otherwise the job is stopped and put into
    /// the
    /// `STOPPED` state.
    ///
    /// If the job is in the `COMPLETED` or `FAILED` state when you call the
    /// `StopDominantLanguageDetectionJob` operation, the operation returns a 400
    /// Internal Request Exception.
    ///
    /// When a job is stopped, any documents already processed are written to the
    /// output
    /// location.
    pub fn stopKeyPhrasesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_key_phrases_detection_job.StopKeyPhrasesDetectionJobInput, options: stop_key_phrases_detection_job.Options) !stop_key_phrases_detection_job.StopKeyPhrasesDetectionJobOutput {
        return stop_key_phrases_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a PII entities detection job in progress.
    pub fn stopPiiEntitiesDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_pii_entities_detection_job.StopPiiEntitiesDetectionJobInput, options: stop_pii_entities_detection_job.Options) !stop_pii_entities_detection_job.StopPiiEntitiesDetectionJobOutput {
        return stop_pii_entities_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a sentiment detection job in progress.
    ///
    /// If the job state is `IN_PROGRESS`, the job is marked for termination and put
    /// into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped, it
    /// is put into the `COMPLETED` state; otherwise the job is be stopped and put
    /// into the
    /// `STOPPED` state.
    ///
    /// If the job is in the `COMPLETED` or `FAILED` state when you call the
    /// `StopDominantLanguageDetectionJob` operation, the operation returns a 400
    /// Internal Request Exception.
    ///
    /// When a job is stopped, any documents already processed are written to the
    /// output
    /// location.
    pub fn stopSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_sentiment_detection_job.StopSentimentDetectionJobInput, options: stop_sentiment_detection_job.Options) !stop_sentiment_detection_job.StopSentimentDetectionJobOutput {
        return stop_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a targeted sentiment detection job in progress.
    ///
    /// If the job state is `IN_PROGRESS`, the job is marked for termination and put
    /// into the `STOP_REQUESTED` state. If the job completes before it can be
    /// stopped, it
    /// is put into the `COMPLETED` state; otherwise the job is be stopped and put
    /// into the
    /// `STOPPED` state.
    ///
    /// If the job is in the `COMPLETED` or `FAILED` state when you call the
    /// `StopDominantLanguageDetectionJob` operation, the operation returns a 400
    /// Internal Request Exception.
    ///
    /// When a job is stopped, any documents already processed are written to the
    /// output
    /// location.
    pub fn stopTargetedSentimentDetectionJob(self: *Self, allocator: std.mem.Allocator, input: stop_targeted_sentiment_detection_job.StopTargetedSentimentDetectionJobInput, options: stop_targeted_sentiment_detection_job.Options) !stop_targeted_sentiment_detection_job.StopTargetedSentimentDetectionJobOutput {
        return stop_targeted_sentiment_detection_job.execute(self, allocator, input, options);
    }

    /// Stops a document classifier training job while in progress.
    ///
    /// If the training job state is `TRAINING`, the job is marked for termination
    /// and
    /// put into the `STOP_REQUESTED` state. If the training job completes before it
    /// can be
    /// stopped, it is put into the `TRAINED`; otherwise the training job is stopped
    /// and
    /// put into the `STOPPED` state and the service sends back an HTTP 200 response
    /// with
    /// an empty HTTP body.
    pub fn stopTrainingDocumentClassifier(self: *Self, allocator: std.mem.Allocator, input: stop_training_document_classifier.StopTrainingDocumentClassifierInput, options: stop_training_document_classifier.Options) !stop_training_document_classifier.StopTrainingDocumentClassifierOutput {
        return stop_training_document_classifier.execute(self, allocator, input, options);
    }

    /// Stops an entity recognizer training job while in progress.
    ///
    /// If the training job state is `TRAINING`, the job is marked for termination
    /// and
    /// put into the `STOP_REQUESTED` state. If the training job completes before it
    /// can be
    /// stopped, it is put into the `TRAINED`; otherwise the training job is stopped
    /// and
    /// putted into the `STOPPED` state and the service sends back an HTTP 200
    /// response
    /// with an empty HTTP body.
    pub fn stopTrainingEntityRecognizer(self: *Self, allocator: std.mem.Allocator, input: stop_training_entity_recognizer.StopTrainingEntityRecognizerInput, options: stop_training_entity_recognizer.Options) !stop_training_entity_recognizer.StopTrainingEntityRecognizerOutput {
        return stop_training_entity_recognizer.execute(self, allocator, input, options);
    }

    /// Associates a specific tag with an Amazon Comprehend resource. A tag is a
    /// key-value pair
    /// that adds as a metadata to a resource used by Amazon Comprehend. For
    /// example, a tag with
    /// "Sales" as the key might be added to a resource to indicate its use by the
    /// sales department.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a specific tag associated with an Amazon Comprehend resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates information about the specified endpoint.
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    pub fn updateEndpoint(self: *Self, allocator: std.mem.Allocator, input: update_endpoint.UpdateEndpointInput, options: update_endpoint.Options) !update_endpoint.UpdateEndpointOutput {
        return update_endpoint.execute(self, allocator, input, options);
    }

    /// Update the configuration information for an existing flywheel.
    pub fn updateFlywheel(self: *Self, allocator: std.mem.Allocator, input: update_flywheel.UpdateFlywheelInput, options: update_flywheel.Options) !update_flywheel.UpdateFlywheelOutput {
        return update_flywheel.execute(self, allocator, input, options);
    }

    pub fn listDatasetsPaginator(self: *Self, params: list_datasets.ListDatasetsInput) paginator.ListDatasetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDocumentClassificationJobsPaginator(self: *Self, params: list_document_classification_jobs.ListDocumentClassificationJobsInput) paginator.ListDocumentClassificationJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDocumentClassifierSummariesPaginator(self: *Self, params: list_document_classifier_summaries.ListDocumentClassifierSummariesInput) paginator.ListDocumentClassifierSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDocumentClassifiersPaginator(self: *Self, params: list_document_classifiers.ListDocumentClassifiersInput) paginator.ListDocumentClassifiersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDominantLanguageDetectionJobsPaginator(self: *Self, params: list_dominant_language_detection_jobs.ListDominantLanguageDetectionJobsInput) paginator.ListDominantLanguageDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEndpointsPaginator(self: *Self, params: list_endpoints.ListEndpointsInput) paginator.ListEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitiesDetectionJobsPaginator(self: *Self, params: list_entities_detection_jobs.ListEntitiesDetectionJobsInput) paginator.ListEntitiesDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntityRecognizerSummariesPaginator(self: *Self, params: list_entity_recognizer_summaries.ListEntityRecognizerSummariesInput) paginator.ListEntityRecognizerSummariesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntityRecognizersPaginator(self: *Self, params: list_entity_recognizers.ListEntityRecognizersInput) paginator.ListEntityRecognizersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventsDetectionJobsPaginator(self: *Self, params: list_events_detection_jobs.ListEventsDetectionJobsInput) paginator.ListEventsDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlywheelIterationHistoryPaginator(self: *Self, params: list_flywheel_iteration_history.ListFlywheelIterationHistoryInput) paginator.ListFlywheelIterationHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listFlywheelsPaginator(self: *Self, params: list_flywheels.ListFlywheelsInput) paginator.ListFlywheelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listKeyPhrasesDetectionJobsPaginator(self: *Self, params: list_key_phrases_detection_jobs.ListKeyPhrasesDetectionJobsInput) paginator.ListKeyPhrasesDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPiiEntitiesDetectionJobsPaginator(self: *Self, params: list_pii_entities_detection_jobs.ListPiiEntitiesDetectionJobsInput) paginator.ListPiiEntitiesDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSentimentDetectionJobsPaginator(self: *Self, params: list_sentiment_detection_jobs.ListSentimentDetectionJobsInput) paginator.ListSentimentDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTargetedSentimentDetectionJobsPaginator(self: *Self, params: list_targeted_sentiment_detection_jobs.ListTargetedSentimentDetectionJobsInput) paginator.ListTargetedSentimentDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTopicsDetectionJobsPaginator(self: *Self, params: list_topics_detection_jobs.ListTopicsDetectionJobsInput) paginator.ListTopicsDetectionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
