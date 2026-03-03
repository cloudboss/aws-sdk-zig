const MedicalContentIdentificationType = @import("medical_content_identification_type.zig").MedicalContentIdentificationType;
const LanguageCode = @import("language_code.zig").LanguageCode;
const OutputLocationType = @import("output_location_type.zig").OutputLocationType;
const Specialty = @import("specialty.zig").Specialty;
const TranscriptionJobStatus = @import("transcription_job_status.zig").TranscriptionJobStatus;
const Type = @import("type.zig").Type;

/// Provides detailed information about a specific medical transcription job.
pub const MedicalTranscriptionJobSummary = struct {
    /// The date and time the specified medical transcription job finished
    /// processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:33:13.922000-07:00` represents a transcription job
    /// that started processing at 12:33 PM UTC-7 on May 4, 2022.
    completion_time: ?i64 = null,

    /// Labels all personal health information (PHI) identified in your transcript.
    /// For more
    /// information, see [Identifying personal health information (PHI) in a
    /// transcription](https://docs.aws.amazon.com/transcribe/latest/dg/phi-id.html).
    content_identification_type: ?MedicalContentIdentificationType = null,

    /// The date and time the specified medical transcription job request was made.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    creation_time: ?i64 = null,

    /// If `TranscriptionJobStatus` is `FAILED`,
    /// `FailureReason` contains information about why the transcription job
    /// failed. See also: [Common
    /// Errors](https://docs.aws.amazon.com/transcribe/latest/APIReference/CommonErrors.html).
    failure_reason: ?[]const u8 = null,

    /// The language code used to create your medical transcription. US English
    /// (`en-US`) is the only supported language for medical
    /// transcriptions.
    language_code: ?LanguageCode = null,

    /// The name of the medical transcription job. Job names are case sensitive and
    /// must be
    /// unique within an Amazon Web Services account.
    medical_transcription_job_name: ?[]const u8 = null,

    /// Indicates where the specified medical transcription output is stored.
    ///
    /// If the value is `CUSTOMER_BUCKET`, the location is the Amazon S3
    /// bucket you specified using the `OutputBucketName` parameter in your request.
    /// If you also included
    /// `OutputKey` in your request, your output is located in the path you
    /// specified in your request.
    ///
    /// If the value is `SERVICE_BUCKET`, the location is a service-managed Amazon
    /// S3 bucket. To access a transcript stored in a service-managed bucket, use
    /// the
    /// URI shown in the `TranscriptFileUri` field.
    output_location_type: ?OutputLocationType = null,

    /// Provides the medical specialty represented in your media.
    specialty: ?Specialty = null,

    /// The date and time your medical transcription job began processing.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.789000-07:00` represents a transcription job
    /// that started processing at 12:32 PM UTC-7 on May 4, 2022.
    start_time: ?i64 = null,

    /// Provides the status of your medical transcription job.
    ///
    /// If the status is `COMPLETED`, the job is finished and you can find the
    /// results at the location specified in `TranscriptFileUri`. If the status is
    /// `FAILED`, `FailureReason` provides details on why your
    /// transcription job failed.
    transcription_job_status: ?TranscriptionJobStatus = null,

    /// Indicates whether the input media is a dictation or a conversation, as
    /// specified in
    /// the `StartMedicalTranscriptionJob` request.
    @"type": ?Type = null,

    pub const json_field_names = .{
        .completion_time = "CompletionTime",
        .content_identification_type = "ContentIdentificationType",
        .creation_time = "CreationTime",
        .failure_reason = "FailureReason",
        .language_code = "LanguageCode",
        .medical_transcription_job_name = "MedicalTranscriptionJobName",
        .output_location_type = "OutputLocationType",
        .specialty = "Specialty",
        .start_time = "StartTime",
        .transcription_job_status = "TranscriptionJobStatus",
        .@"type" = "Type",
    };
};
