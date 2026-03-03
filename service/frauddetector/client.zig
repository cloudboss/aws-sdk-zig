const aws = @import("aws");
const std = @import("std");

const batch_create_variable = @import("batch_create_variable.zig");
const batch_get_variable = @import("batch_get_variable.zig");
const cancel_batch_import_job = @import("cancel_batch_import_job.zig");
const cancel_batch_prediction_job = @import("cancel_batch_prediction_job.zig");
const create_batch_import_job = @import("create_batch_import_job.zig");
const create_batch_prediction_job = @import("create_batch_prediction_job.zig");
const create_detector_version = @import("create_detector_version.zig");
const create_list = @import("create_list.zig");
const create_model = @import("create_model.zig");
const create_model_version = @import("create_model_version.zig");
const create_rule = @import("create_rule.zig");
const create_variable = @import("create_variable.zig");
const delete_batch_import_job = @import("delete_batch_import_job.zig");
const delete_batch_prediction_job = @import("delete_batch_prediction_job.zig");
const delete_detector = @import("delete_detector.zig");
const delete_detector_version = @import("delete_detector_version.zig");
const delete_entity_type = @import("delete_entity_type.zig");
const delete_event = @import("delete_event.zig");
const delete_event_type = @import("delete_event_type.zig");
const delete_events_by_event_type = @import("delete_events_by_event_type.zig");
const delete_external_model = @import("delete_external_model.zig");
const delete_label = @import("delete_label.zig");
const delete_list = @import("delete_list.zig");
const delete_model = @import("delete_model.zig");
const delete_model_version = @import("delete_model_version.zig");
const delete_outcome = @import("delete_outcome.zig");
const delete_rule = @import("delete_rule.zig");
const delete_variable = @import("delete_variable.zig");
const describe_detector = @import("describe_detector.zig");
const describe_model_versions = @import("describe_model_versions.zig");
const get_batch_import_jobs = @import("get_batch_import_jobs.zig");
const get_batch_prediction_jobs = @import("get_batch_prediction_jobs.zig");
const get_delete_events_by_event_type_status = @import("get_delete_events_by_event_type_status.zig");
const get_detector_version = @import("get_detector_version.zig");
const get_detectors = @import("get_detectors.zig");
const get_entity_types = @import("get_entity_types.zig");
const get_event = @import("get_event.zig");
const get_event_prediction = @import("get_event_prediction.zig");
const get_event_prediction_metadata = @import("get_event_prediction_metadata.zig");
const get_event_types = @import("get_event_types.zig");
const get_external_models = @import("get_external_models.zig");
const get_kms_encryption_key = @import("get_kms_encryption_key.zig");
const get_labels = @import("get_labels.zig");
const get_list_elements = @import("get_list_elements.zig");
const get_lists_metadata = @import("get_lists_metadata.zig");
const get_model_version = @import("get_model_version.zig");
const get_models = @import("get_models.zig");
const get_outcomes = @import("get_outcomes.zig");
const get_rules = @import("get_rules.zig");
const get_variables = @import("get_variables.zig");
const list_event_predictions = @import("list_event_predictions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_detector = @import("put_detector.zig");
const put_entity_type = @import("put_entity_type.zig");
const put_event_type = @import("put_event_type.zig");
const put_external_model = @import("put_external_model.zig");
const put_kms_encryption_key = @import("put_kms_encryption_key.zig");
const put_label = @import("put_label.zig");
const put_outcome = @import("put_outcome.zig");
const send_event = @import("send_event.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_detector_version = @import("update_detector_version.zig");
const update_detector_version_metadata = @import("update_detector_version_metadata.zig");
const update_detector_version_status = @import("update_detector_version_status.zig");
const update_event_label = @import("update_event_label.zig");
const update_list = @import("update_list.zig");
const update_model = @import("update_model.zig");
const update_model_version = @import("update_model_version.zig");
const update_model_version_status = @import("update_model_version_status.zig");
const update_rule_metadata = @import("update_rule_metadata.zig");
const update_rule_version = @import("update_rule_version.zig");
const update_variable = @import("update_variable.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "FraudDetector";

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

    /// Creates a batch of variables.
    pub fn batchCreateVariable(self: *Self, allocator: std.mem.Allocator, input: batch_create_variable.BatchCreateVariableInput, options: CallOptions) !batch_create_variable.BatchCreateVariableOutput {
        return batch_create_variable.execute(self, allocator, input, options);
    }

    /// Gets a batch of variables.
    pub fn batchGetVariable(self: *Self, allocator: std.mem.Allocator, input: batch_get_variable.BatchGetVariableInput, options: CallOptions) !batch_get_variable.BatchGetVariableOutput {
        return batch_get_variable.execute(self, allocator, input, options);
    }

    /// Cancels an in-progress batch import job.
    pub fn cancelBatchImportJob(self: *Self, allocator: std.mem.Allocator, input: cancel_batch_import_job.CancelBatchImportJobInput, options: CallOptions) !cancel_batch_import_job.CancelBatchImportJobOutput {
        return cancel_batch_import_job.execute(self, allocator, input, options);
    }

    /// Cancels the specified batch prediction job.
    pub fn cancelBatchPredictionJob(self: *Self, allocator: std.mem.Allocator, input: cancel_batch_prediction_job.CancelBatchPredictionJobInput, options: CallOptions) !cancel_batch_prediction_job.CancelBatchPredictionJobOutput {
        return cancel_batch_prediction_job.execute(self, allocator, input, options);
    }

    /// Creates a batch import job.
    pub fn createBatchImportJob(self: *Self, allocator: std.mem.Allocator, input: create_batch_import_job.CreateBatchImportJobInput, options: CallOptions) !create_batch_import_job.CreateBatchImportJobOutput {
        return create_batch_import_job.execute(self, allocator, input, options);
    }

    /// Creates a batch prediction job.
    pub fn createBatchPredictionJob(self: *Self, allocator: std.mem.Allocator, input: create_batch_prediction_job.CreateBatchPredictionJobInput, options: CallOptions) !create_batch_prediction_job.CreateBatchPredictionJobOutput {
        return create_batch_prediction_job.execute(self, allocator, input, options);
    }

    /// Creates a detector version. The detector version starts in a `DRAFT` status.
    pub fn createDetectorVersion(self: *Self, allocator: std.mem.Allocator, input: create_detector_version.CreateDetectorVersionInput, options: CallOptions) !create_detector_version.CreateDetectorVersionOutput {
        return create_detector_version.execute(self, allocator, input, options);
    }

    /// Creates a list.
    ///
    /// List is a set of input data for a variable in your event dataset. You use
    /// the input data in a rule that's associated with your detector.
    /// For more information, see
    /// [Lists](https://docs.aws.amazon.com/frauddetector/latest/ug/lists.html).
    pub fn createList(self: *Self, allocator: std.mem.Allocator, input: create_list.CreateListInput, options: CallOptions) !create_list.CreateListOutput {
        return create_list.execute(self, allocator, input, options);
    }

    /// Creates a model using the specified model type.
    pub fn createModel(self: *Self, allocator: std.mem.Allocator, input: create_model.CreateModelInput, options: CallOptions) !create_model.CreateModelOutput {
        return create_model.execute(self, allocator, input, options);
    }

    /// Creates a version of the model using the specified model type and model id.
    pub fn createModelVersion(self: *Self, allocator: std.mem.Allocator, input: create_model_version.CreateModelVersionInput, options: CallOptions) !create_model_version.CreateModelVersionOutput {
        return create_model_version.execute(self, allocator, input, options);
    }

    /// Creates a rule for use with the specified detector.
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: CallOptions) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// Creates a variable.
    pub fn createVariable(self: *Self, allocator: std.mem.Allocator, input: create_variable.CreateVariableInput, options: CallOptions) !create_variable.CreateVariableOutput {
        return create_variable.execute(self, allocator, input, options);
    }

    /// Deletes the specified batch import job ID record. This action does not
    /// delete the data that was batch imported.
    pub fn deleteBatchImportJob(self: *Self, allocator: std.mem.Allocator, input: delete_batch_import_job.DeleteBatchImportJobInput, options: CallOptions) !delete_batch_import_job.DeleteBatchImportJobOutput {
        return delete_batch_import_job.execute(self, allocator, input, options);
    }

    /// Deletes a batch prediction job.
    pub fn deleteBatchPredictionJob(self: *Self, allocator: std.mem.Allocator, input: delete_batch_prediction_job.DeleteBatchPredictionJobInput, options: CallOptions) !delete_batch_prediction_job.DeleteBatchPredictionJobOutput {
        return delete_batch_prediction_job.execute(self, allocator, input, options);
    }

    /// Deletes the detector. Before deleting a detector, you must first delete all
    /// detector versions and rule versions associated with the detector.
    ///
    /// When you delete a detector, Amazon Fraud Detector permanently deletes the
    /// detector and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteDetector(self: *Self, allocator: std.mem.Allocator, input: delete_detector.DeleteDetectorInput, options: CallOptions) !delete_detector.DeleteDetectorOutput {
        return delete_detector.execute(self, allocator, input, options);
    }

    /// Deletes the detector version. You cannot delete detector versions that are
    /// in `ACTIVE` status.
    ///
    /// When you delete a detector version, Amazon Fraud Detector permanently
    /// deletes the detector and the data is no longer stored in Amazon Fraud
    /// Detector.
    pub fn deleteDetectorVersion(self: *Self, allocator: std.mem.Allocator, input: delete_detector_version.DeleteDetectorVersionInput, options: CallOptions) !delete_detector_version.DeleteDetectorVersionOutput {
        return delete_detector_version.execute(self, allocator, input, options);
    }

    /// Deletes an entity type.
    ///
    /// You cannot delete an entity type that is included in an event type.
    ///
    /// When you delete an entity type, Amazon Fraud Detector permanently deletes
    /// that entity type and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteEntityType(self: *Self, allocator: std.mem.Allocator, input: delete_entity_type.DeleteEntityTypeInput, options: CallOptions) !delete_entity_type.DeleteEntityTypeOutput {
        return delete_entity_type.execute(self, allocator, input, options);
    }

    /// Deletes the specified event.
    ///
    /// When you delete an event, Amazon Fraud Detector permanently deletes that
    /// event and the event data is no longer stored in Amazon Fraud Detector.
    /// If `deleteAuditHistory` is `True`, event data is available through search
    /// for up to 30 seconds after the delete operation is completed.
    pub fn deleteEvent(self: *Self, allocator: std.mem.Allocator, input: delete_event.DeleteEventInput, options: CallOptions) !delete_event.DeleteEventOutput {
        return delete_event.execute(self, allocator, input, options);
    }

    /// Deletes an event type.
    ///
    /// You cannot delete an event type that is used in a detector or a model.
    ///
    /// When you delete an event type, Amazon Fraud Detector permanently deletes
    /// that event type and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteEventType(self: *Self, allocator: std.mem.Allocator, input: delete_event_type.DeleteEventTypeInput, options: CallOptions) !delete_event_type.DeleteEventTypeOutput {
        return delete_event_type.execute(self, allocator, input, options);
    }

    /// Deletes all events of a particular event type.
    pub fn deleteEventsByEventType(self: *Self, allocator: std.mem.Allocator, input: delete_events_by_event_type.DeleteEventsByEventTypeInput, options: CallOptions) !delete_events_by_event_type.DeleteEventsByEventTypeOutput {
        return delete_events_by_event_type.execute(self, allocator, input, options);
    }

    /// Removes a SageMaker model from Amazon Fraud Detector.
    ///
    /// You can remove an Amazon SageMaker model if it is not associated with a
    /// detector version. Removing a SageMaker model disconnects it from Amazon
    /// Fraud Detector, but the model remains available in SageMaker.
    pub fn deleteExternalModel(self: *Self, allocator: std.mem.Allocator, input: delete_external_model.DeleteExternalModelInput, options: CallOptions) !delete_external_model.DeleteExternalModelOutput {
        return delete_external_model.execute(self, allocator, input, options);
    }

    /// Deletes a label.
    ///
    /// You cannot delete labels that are included in an event type in Amazon Fraud
    /// Detector.
    ///
    /// You cannot delete a label assigned to an event ID. You must first delete the
    /// relevant event ID.
    ///
    /// When you delete a label, Amazon Fraud Detector permanently deletes that
    /// label and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteLabel(self: *Self, allocator: std.mem.Allocator, input: delete_label.DeleteLabelInput, options: CallOptions) !delete_label.DeleteLabelOutput {
        return delete_label.execute(self, allocator, input, options);
    }

    /// Deletes the list, provided it is not used in a rule.
    ///
    /// When you delete a list, Amazon Fraud Detector permanently deletes that list
    /// and the elements in the list.
    pub fn deleteList(self: *Self, allocator: std.mem.Allocator, input: delete_list.DeleteListInput, options: CallOptions) !delete_list.DeleteListOutput {
        return delete_list.execute(self, allocator, input, options);
    }

    /// Deletes a model.
    ///
    /// You can delete models and model versions in Amazon Fraud Detector, provided
    /// that they are not associated with a detector version.
    ///
    /// When you delete a model, Amazon Fraud Detector permanently deletes that
    /// model and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteModel(self: *Self, allocator: std.mem.Allocator, input: delete_model.DeleteModelInput, options: CallOptions) !delete_model.DeleteModelOutput {
        return delete_model.execute(self, allocator, input, options);
    }

    /// Deletes a model version.
    ///
    /// You can delete models and model versions in Amazon Fraud Detector, provided
    /// that they are not associated with a detector version.
    ///
    /// When you delete a model version, Amazon Fraud Detector permanently deletes
    /// that model version and the data is no longer stored in Amazon Fraud
    /// Detector.
    pub fn deleteModelVersion(self: *Self, allocator: std.mem.Allocator, input: delete_model_version.DeleteModelVersionInput, options: CallOptions) !delete_model_version.DeleteModelVersionOutput {
        return delete_model_version.execute(self, allocator, input, options);
    }

    /// Deletes an outcome.
    ///
    /// You cannot delete an outcome that is used in a rule version.
    ///
    /// When you delete an outcome, Amazon Fraud Detector permanently deletes that
    /// outcome and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteOutcome(self: *Self, allocator: std.mem.Allocator, input: delete_outcome.DeleteOutcomeInput, options: CallOptions) !delete_outcome.DeleteOutcomeOutput {
        return delete_outcome.execute(self, allocator, input, options);
    }

    /// Deletes the rule. You cannot delete a rule if it is used by an `ACTIVE` or
    /// `INACTIVE` detector version.
    ///
    /// When you delete a rule, Amazon Fraud Detector permanently deletes that rule
    /// and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: CallOptions) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// Deletes a variable.
    ///
    /// You can't delete variables that are included in an event type in Amazon
    /// Fraud Detector.
    ///
    /// Amazon Fraud Detector automatically deletes model output variables and
    /// SageMaker model output variables when you delete the model. You can't delete
    /// these variables manually.
    ///
    /// When you delete a variable, Amazon Fraud Detector permanently deletes that
    /// variable and the data is no longer stored in Amazon Fraud Detector.
    pub fn deleteVariable(self: *Self, allocator: std.mem.Allocator, input: delete_variable.DeleteVariableInput, options: CallOptions) !delete_variable.DeleteVariableOutput {
        return delete_variable.execute(self, allocator, input, options);
    }

    /// Gets all versions for a specified detector.
    pub fn describeDetector(self: *Self, allocator: std.mem.Allocator, input: describe_detector.DescribeDetectorInput, options: CallOptions) !describe_detector.DescribeDetectorOutput {
        return describe_detector.execute(self, allocator, input, options);
    }

    /// Gets all of the model versions for the specified model type or for the
    /// specified model type and model ID. You can also get details for a single,
    /// specified model version.
    pub fn describeModelVersions(self: *Self, allocator: std.mem.Allocator, input: describe_model_versions.DescribeModelVersionsInput, options: CallOptions) !describe_model_versions.DescribeModelVersionsOutput {
        return describe_model_versions.execute(self, allocator, input, options);
    }

    /// Gets all batch import jobs or a specific job of the specified ID. This is a
    /// paginated API. If you provide a null `maxResults`,
    /// this action retrieves a maximum of 50 records per page. If you provide a
    /// `maxResults`, the value must be between 1 and 50.
    /// To get the next page results, provide the pagination token from the
    /// `GetBatchImportJobsResponse` as part of your request.
    /// A null pagination token fetches the records from the beginning.
    pub fn getBatchImportJobs(self: *Self, allocator: std.mem.Allocator, input: get_batch_import_jobs.GetBatchImportJobsInput, options: CallOptions) !get_batch_import_jobs.GetBatchImportJobsOutput {
        return get_batch_import_jobs.execute(self, allocator, input, options);
    }

    /// Gets all batch prediction jobs or a specific job if you specify a job ID.
    /// This is a paginated API. If you provide a null maxResults, this action
    /// retrieves a maximum of 50 records per page. If you provide a maxResults, the
    /// value must be between 1 and 50. To get the next page results, provide the
    /// pagination token from the GetBatchPredictionJobsResponse as part of your
    /// request. A null pagination token fetches the records from the beginning.
    pub fn getBatchPredictionJobs(self: *Self, allocator: std.mem.Allocator, input: get_batch_prediction_jobs.GetBatchPredictionJobsInput, options: CallOptions) !get_batch_prediction_jobs.GetBatchPredictionJobsOutput {
        return get_batch_prediction_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves the status of a `DeleteEventsByEventType` action.
    pub fn getDeleteEventsByEventTypeStatus(self: *Self, allocator: std.mem.Allocator, input: get_delete_events_by_event_type_status.GetDeleteEventsByEventTypeStatusInput, options: CallOptions) !get_delete_events_by_event_type_status.GetDeleteEventsByEventTypeStatusOutput {
        return get_delete_events_by_event_type_status.execute(self, allocator, input, options);
    }

    /// Gets a particular detector version.
    pub fn getDetectorVersion(self: *Self, allocator: std.mem.Allocator, input: get_detector_version.GetDetectorVersionInput, options: CallOptions) !get_detector_version.GetDetectorVersionOutput {
        return get_detector_version.execute(self, allocator, input, options);
    }

    /// Gets all detectors or a single detector if a `detectorId` is specified. This
    /// is a paginated API. If you
    /// provide a null `maxResults`, this action retrieves a maximum of 10 records
    /// per page. If you provide a `maxResults`, the value must be between 5 and 10.
    /// To get the next page results, provide the pagination token from the
    /// `GetDetectorsResponse` as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getDetectors(self: *Self, allocator: std.mem.Allocator, input: get_detectors.GetDetectorsInput, options: CallOptions) !get_detectors.GetDetectorsOutput {
        return get_detectors.execute(self, allocator, input, options);
    }

    /// Gets all entity types or a specific entity type if a name is specified. This
    /// is a paginated API. If you
    /// provide a null `maxResults`, this action retrieves a maximum of 10 records
    /// per page. If you provide a `maxResults`, the value must be between 5 and 10.
    /// To get the next page results, provide the pagination token from the
    /// `GetEntityTypesResponse` as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getEntityTypes(self: *Self, allocator: std.mem.Allocator, input: get_entity_types.GetEntityTypesInput, options: CallOptions) !get_entity_types.GetEntityTypesOutput {
        return get_entity_types.execute(self, allocator, input, options);
    }

    /// Retrieves details of events stored with Amazon Fraud Detector. This action
    /// does not retrieve prediction results.
    pub fn getEvent(self: *Self, allocator: std.mem.Allocator, input: get_event.GetEventInput, options: CallOptions) !get_event.GetEventOutput {
        return get_event.execute(self, allocator, input, options);
    }

    /// Evaluates an event against a detector version. If a version ID is not
    /// provided, the detector’s (`ACTIVE`) version is used.
    pub fn getEventPrediction(self: *Self, allocator: std.mem.Allocator, input: get_event_prediction.GetEventPredictionInput, options: CallOptions) !get_event_prediction.GetEventPredictionOutput {
        return get_event_prediction.execute(self, allocator, input, options);
    }

    /// Gets details of the past fraud predictions for the specified event ID, event
    /// type, detector ID, and detector version ID that was generated in the
    /// specified time period.
    pub fn getEventPredictionMetadata(self: *Self, allocator: std.mem.Allocator, input: get_event_prediction_metadata.GetEventPredictionMetadataInput, options: CallOptions) !get_event_prediction_metadata.GetEventPredictionMetadataOutput {
        return get_event_prediction_metadata.execute(self, allocator, input, options);
    }

    /// Gets all event types or a specific event type if name is provided. This is a
    /// paginated API. If you
    /// provide a null `maxResults`, this action retrieves a maximum of 10 records
    /// per page. If you provide a `maxResults`, the value must be between 5 and 10.
    /// To get the next page results, provide the pagination token from the
    /// `GetEventTypesResponse` as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getEventTypes(self: *Self, allocator: std.mem.Allocator, input: get_event_types.GetEventTypesInput, options: CallOptions) !get_event_types.GetEventTypesOutput {
        return get_event_types.execute(self, allocator, input, options);
    }

    /// Gets the details for one or more Amazon SageMaker models that have been
    /// imported into the
    /// service. This is a paginated API. If you provide a null `maxResults`, this
    /// actions retrieves a maximum of 10 records per page. If you provide a
    /// `maxResults`, the value must be between 5 and 10. To get the next page
    /// results, provide the pagination token from the `GetExternalModelsResult` as
    /// part
    /// of your request. A null pagination token fetches the records from the
    /// beginning.
    pub fn getExternalModels(self: *Self, allocator: std.mem.Allocator, input: get_external_models.GetExternalModelsInput, options: CallOptions) !get_external_models.GetExternalModelsOutput {
        return get_external_models.execute(self, allocator, input, options);
    }

    /// Gets the encryption key if a KMS key has been specified to be used to
    /// encrypt content in Amazon Fraud Detector.
    pub fn getKmsEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: get_kms_encryption_key.GetKMSEncryptionKeyInput, options: CallOptions) !get_kms_encryption_key.GetKMSEncryptionKeyOutput {
        return get_kms_encryption_key.execute(self, allocator, input, options);
    }

    /// Gets all labels or a specific label if name is provided. This is a paginated
    /// API. If you
    /// provide a null `maxResults`, this action retrieves a maximum of 50 records
    /// per page. If you provide a `maxResults`, the value must be between 10 and
    /// 50.
    /// To get the next page results, provide the pagination token from the
    /// `GetGetLabelsResponse` as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getLabels(self: *Self, allocator: std.mem.Allocator, input: get_labels.GetLabelsInput, options: CallOptions) !get_labels.GetLabelsOutput {
        return get_labels.execute(self, allocator, input, options);
    }

    /// Gets all the elements in the specified list.
    pub fn getListElements(self: *Self, allocator: std.mem.Allocator, input: get_list_elements.GetListElementsInput, options: CallOptions) !get_list_elements.GetListElementsOutput {
        return get_list_elements.execute(self, allocator, input, options);
    }

    /// Gets the metadata of either all the lists under the account or the specified
    /// list.
    pub fn getListsMetadata(self: *Self, allocator: std.mem.Allocator, input: get_lists_metadata.GetListsMetadataInput, options: CallOptions) !get_lists_metadata.GetListsMetadataOutput {
        return get_lists_metadata.execute(self, allocator, input, options);
    }

    /// Gets the details of the specified model version.
    pub fn getModelVersion(self: *Self, allocator: std.mem.Allocator, input: get_model_version.GetModelVersionInput, options: CallOptions) !get_model_version.GetModelVersionOutput {
        return get_model_version.execute(self, allocator, input, options);
    }

    /// Gets one or more models. Gets all models for the Amazon Web Services account
    /// if no model type and no model id provided. Gets all models for the Amazon
    /// Web Services account and model type, if the model type is specified but
    /// model id is not provided. Gets a specific model if (model type, model id)
    /// tuple is specified.
    ///
    /// This is a paginated API. If you
    /// provide a null `maxResults`, this action retrieves a maximum of 10 records
    /// per page. If you provide a `maxResults`, the value must be between 1 and 10.
    /// To get the next page results, provide the pagination token from the
    /// response as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getModels(self: *Self, allocator: std.mem.Allocator, input: get_models.GetModelsInput, options: CallOptions) !get_models.GetModelsOutput {
        return get_models.execute(self, allocator, input, options);
    }

    /// Gets one or more outcomes. This is a paginated
    /// API. If you provide a null `maxResults`, this actions retrieves a maximum of
    /// 100 records per page. If you provide a `maxResults`, the value must be
    /// between 50 and 100. To get the next page results, provide the pagination
    /// token from the
    /// `GetOutcomesResult` as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn getOutcomes(self: *Self, allocator: std.mem.Allocator, input: get_outcomes.GetOutcomesInput, options: CallOptions) !get_outcomes.GetOutcomesOutput {
        return get_outcomes.execute(self, allocator, input, options);
    }

    /// Get all rules for a detector (paginated) if `ruleId` and `ruleVersion` are
    /// not specified. Gets all rules for the detector and the `ruleId` if present
    /// (paginated). Gets a specific rule if both the `ruleId` and the `ruleVersion`
    /// are specified.
    ///
    /// This is a paginated API. Providing null maxResults results in retrieving
    /// maximum of 100 records per page. If you provide maxResults the value must be
    /// between 50 and 100. To get the next page result, a provide a pagination
    /// token from GetRulesResult as part of your request. Null pagination token
    /// fetches the records from the beginning.
    pub fn getRules(self: *Self, allocator: std.mem.Allocator, input: get_rules.GetRulesInput, options: CallOptions) !get_rules.GetRulesOutput {
        return get_rules.execute(self, allocator, input, options);
    }

    /// Gets all of the variables or the specific variable. This is a
    /// paginated API. Providing null `maxSizePerPage` results in retrieving maximum
    /// of
    /// 100 records per page. If you provide `maxSizePerPage` the value must be
    /// between
    /// 50 and 100. To get the next page result, a provide a pagination token from
    /// `GetVariablesResult` as part of your request. Null pagination token
    /// fetches the records from the beginning.
    pub fn getVariables(self: *Self, allocator: std.mem.Allocator, input: get_variables.GetVariablesInput, options: CallOptions) !get_variables.GetVariablesOutput {
        return get_variables.execute(self, allocator, input, options);
    }

    /// Gets a list of past predictions. The list can be filtered by detector ID,
    /// detector version ID, event ID, event type, or by specifying a time period.
    /// If filter is not specified, the most recent prediction is returned.
    ///
    /// For example, the following filter lists all past predictions for `xyz` event
    /// type -
    /// `{
    /// "eventType":{
    /// "value": "xyz" }”
    /// } `
    ///
    /// This is a paginated API. If you provide a null `maxResults`, this action
    /// will retrieve a maximum of 10 records per page.
    /// If you provide a `maxResults`, the value must be between 50 and 100. To get
    /// the next page results, provide
    /// the `nextToken` from the response as part of your request. A null
    /// `nextToken` fetches the records from the beginning.
    pub fn listEventPredictions(self: *Self, allocator: std.mem.Allocator, input: list_event_predictions.ListEventPredictionsInput, options: CallOptions) !list_event_predictions.ListEventPredictionsOutput {
        return list_event_predictions.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with the resource. This is a paginated API. To get
    /// the next page results, provide the pagination token from the
    /// response as part of your request. A null pagination token
    /// fetches the records from the beginning.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates a detector.
    pub fn putDetector(self: *Self, allocator: std.mem.Allocator, input: put_detector.PutDetectorInput, options: CallOptions) !put_detector.PutDetectorOutput {
        return put_detector.execute(self, allocator, input, options);
    }

    /// Creates or updates an entity type. An entity represents who is performing
    /// the event. As part of a fraud prediction, you pass the entity ID to indicate
    /// the specific entity who performed the event. An entity type classifies the
    /// entity. Example classifications include customer, merchant, or account.
    pub fn putEntityType(self: *Self, allocator: std.mem.Allocator, input: put_entity_type.PutEntityTypeInput, options: CallOptions) !put_entity_type.PutEntityTypeOutput {
        return put_entity_type.execute(self, allocator, input, options);
    }

    /// Creates or updates an event type. An event is a business activity that is
    /// evaluated for fraud risk. With Amazon Fraud Detector, you generate fraud
    /// predictions for events. An event type defines the structure for an event
    /// sent to Amazon Fraud Detector. This includes the variables sent as part of
    /// the event, the entity performing the event (such as a customer), and the
    /// labels that classify the event. Example event types include online payment
    /// transactions, account registrations, and authentications.
    pub fn putEventType(self: *Self, allocator: std.mem.Allocator, input: put_event_type.PutEventTypeInput, options: CallOptions) !put_event_type.PutEventTypeOutput {
        return put_event_type.execute(self, allocator, input, options);
    }

    /// Creates or updates an Amazon SageMaker model endpoint. You can also use this
    /// action to update the configuration of the model endpoint, including the IAM
    /// role and/or the mapped variables.
    pub fn putExternalModel(self: *Self, allocator: std.mem.Allocator, input: put_external_model.PutExternalModelInput, options: CallOptions) !put_external_model.PutExternalModelOutput {
        return put_external_model.execute(self, allocator, input, options);
    }

    /// Specifies the KMS key to be used to encrypt content in Amazon Fraud
    /// Detector.
    pub fn putKmsEncryptionKey(self: *Self, allocator: std.mem.Allocator, input: put_kms_encryption_key.PutKMSEncryptionKeyInput, options: CallOptions) !put_kms_encryption_key.PutKMSEncryptionKeyOutput {
        return put_kms_encryption_key.execute(self, allocator, input, options);
    }

    /// Creates or updates label. A label classifies an event as fraudulent or
    /// legitimate. Labels are associated with event types and used to train
    /// supervised machine learning models in Amazon Fraud Detector.
    pub fn putLabel(self: *Self, allocator: std.mem.Allocator, input: put_label.PutLabelInput, options: CallOptions) !put_label.PutLabelOutput {
        return put_label.execute(self, allocator, input, options);
    }

    /// Creates or updates an outcome.
    pub fn putOutcome(self: *Self, allocator: std.mem.Allocator, input: put_outcome.PutOutcomeInput, options: CallOptions) !put_outcome.PutOutcomeOutput {
        return put_outcome.execute(self, allocator, input, options);
    }

    /// Stores events in Amazon Fraud Detector without generating fraud predictions
    /// for those events. For example, you can use `SendEvent` to upload a
    /// historical dataset, which you can then later use to train a model.
    pub fn sendEvent(self: *Self, allocator: std.mem.Allocator, input: send_event.SendEventInput, options: CallOptions) !send_event.SendEventOutput {
        return send_event.execute(self, allocator, input, options);
    }

    /// Assigns tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a detector version. The detector version attributes that you can
    /// update include models, external model endpoints, rules, rule execution mode,
    /// and description. You can only update a `DRAFT` detector version.
    pub fn updateDetectorVersion(self: *Self, allocator: std.mem.Allocator, input: update_detector_version.UpdateDetectorVersionInput, options: CallOptions) !update_detector_version.UpdateDetectorVersionOutput {
        return update_detector_version.execute(self, allocator, input, options);
    }

    /// Updates the detector version's description. You can update the metadata for
    /// any detector version (`DRAFT, ACTIVE,` or
    /// `INACTIVE`).
    pub fn updateDetectorVersionMetadata(self: *Self, allocator: std.mem.Allocator, input: update_detector_version_metadata.UpdateDetectorVersionMetadataInput, options: CallOptions) !update_detector_version_metadata.UpdateDetectorVersionMetadataOutput {
        return update_detector_version_metadata.execute(self, allocator, input, options);
    }

    /// Updates the detector version’s status. You can perform the following
    /// promotions or
    /// demotions using `UpdateDetectorVersionStatus`: `DRAFT` to `ACTIVE`, `ACTIVE`
    /// to `INACTIVE`, and `INACTIVE` to `ACTIVE`.
    pub fn updateDetectorVersionStatus(self: *Self, allocator: std.mem.Allocator, input: update_detector_version_status.UpdateDetectorVersionStatusInput, options: CallOptions) !update_detector_version_status.UpdateDetectorVersionStatusOutput {
        return update_detector_version_status.execute(self, allocator, input, options);
    }

    /// Updates the specified event with a new label.
    pub fn updateEventLabel(self: *Self, allocator: std.mem.Allocator, input: update_event_label.UpdateEventLabelInput, options: CallOptions) !update_event_label.UpdateEventLabelOutput {
        return update_event_label.execute(self, allocator, input, options);
    }

    /// Updates a list.
    pub fn updateList(self: *Self, allocator: std.mem.Allocator, input: update_list.UpdateListInput, options: CallOptions) !update_list.UpdateListOutput {
        return update_list.execute(self, allocator, input, options);
    }

    /// Updates model description.
    pub fn updateModel(self: *Self, allocator: std.mem.Allocator, input: update_model.UpdateModelInput, options: CallOptions) !update_model.UpdateModelOutput {
        return update_model.execute(self, allocator, input, options);
    }

    /// Updates a model version. Updating a model version retrains an existing model
    /// version using updated training data and produces a new minor version of the
    /// model. You can update the training data set location and data access role
    /// attributes using this action. This action creates and trains a new minor
    /// version of the model, for example version 1.01, 1.02, 1.03.
    pub fn updateModelVersion(self: *Self, allocator: std.mem.Allocator, input: update_model_version.UpdateModelVersionInput, options: CallOptions) !update_model_version.UpdateModelVersionOutput {
        return update_model_version.execute(self, allocator, input, options);
    }

    /// Updates the status of a model version.
    ///
    /// You can perform the following status updates:
    ///
    /// * Change the `TRAINING_IN_PROGRESS` status to `TRAINING_CANCELLED`.
    ///
    /// * Change the `TRAINING_COMPLETE` status to `ACTIVE`.
    ///
    /// * Change `ACTIVE` to `INACTIVE`.
    pub fn updateModelVersionStatus(self: *Self, allocator: std.mem.Allocator, input: update_model_version_status.UpdateModelVersionStatusInput, options: CallOptions) !update_model_version_status.UpdateModelVersionStatusOutput {
        return update_model_version_status.execute(self, allocator, input, options);
    }

    /// Updates a rule's metadata. The description attribute can be updated.
    pub fn updateRuleMetadata(self: *Self, allocator: std.mem.Allocator, input: update_rule_metadata.UpdateRuleMetadataInput, options: CallOptions) !update_rule_metadata.UpdateRuleMetadataOutput {
        return update_rule_metadata.execute(self, allocator, input, options);
    }

    /// Updates a rule version resulting in a new rule version. Updates a rule
    /// version resulting in a new rule version (version 1, 2, 3 ...).
    pub fn updateRuleVersion(self: *Self, allocator: std.mem.Allocator, input: update_rule_version.UpdateRuleVersionInput, options: CallOptions) !update_rule_version.UpdateRuleVersionOutput {
        return update_rule_version.execute(self, allocator, input, options);
    }

    /// Updates a variable.
    pub fn updateVariable(self: *Self, allocator: std.mem.Allocator, input: update_variable.UpdateVariableInput, options: CallOptions) !update_variable.UpdateVariableOutput {
        return update_variable.execute(self, allocator, input, options);
    }

    pub fn describeModelVersionsPaginator(self: *Self, params: describe_model_versions.DescribeModelVersionsInput) paginator.DescribeModelVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBatchImportJobsPaginator(self: *Self, params: get_batch_import_jobs.GetBatchImportJobsInput) paginator.GetBatchImportJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getBatchPredictionJobsPaginator(self: *Self, params: get_batch_prediction_jobs.GetBatchPredictionJobsInput) paginator.GetBatchPredictionJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getDetectorsPaginator(self: *Self, params: get_detectors.GetDetectorsInput) paginator.GetDetectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEntityTypesPaginator(self: *Self, params: get_entity_types.GetEntityTypesInput) paginator.GetEntityTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getEventTypesPaginator(self: *Self, params: get_event_types.GetEventTypesInput) paginator.GetEventTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getExternalModelsPaginator(self: *Self, params: get_external_models.GetExternalModelsInput) paginator.GetExternalModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getLabelsPaginator(self: *Self, params: get_labels.GetLabelsInput) paginator.GetLabelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getListElementsPaginator(self: *Self, params: get_list_elements.GetListElementsInput) paginator.GetListElementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getListsMetadataPaginator(self: *Self, params: get_lists_metadata.GetListsMetadataInput) paginator.GetListsMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getModelsPaginator(self: *Self, params: get_models.GetModelsInput) paginator.GetModelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getOutcomesPaginator(self: *Self, params: get_outcomes.GetOutcomesInput) paginator.GetOutcomesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getRulesPaginator(self: *Self, params: get_rules.GetRulesInput) paginator.GetRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getVariablesPaginator(self: *Self, params: get_variables.GetVariablesInput) paginator.GetVariablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventPredictionsPaginator(self: *Self, params: list_event_predictions.ListEventPredictionsInput) paginator.ListEventPredictionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
