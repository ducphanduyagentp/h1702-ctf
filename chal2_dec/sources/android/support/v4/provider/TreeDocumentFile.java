package android.support.v4.provider;

import android.content.Context;
import android.net.Uri;

class TreeDocumentFile extends DocumentFile {
    private Context mContext;
    private Uri mUri;

    TreeDocumentFile(DocumentFile documentFile, Context context, Uri uri) {
        super(documentFile);
        this.mContext = context;
        this.mUri = uri;
    }

    public DocumentFile createFile(String str, String str2) {
        str = DocumentsContractApi21.createFile(this.mContext, this.mUri, str, str2);
        return str != null ? new TreeDocumentFile(this, this.mContext, str) : null;
    }

    public DocumentFile createDirectory(String str) {
        str = DocumentsContractApi21.createDirectory(this.mContext, this.mUri, str);
        return str != null ? new TreeDocumentFile(this, this.mContext, str) : null;
    }

    public Uri getUri() {
        return this.mUri;
    }

    public String getName() {
        return DocumentsContractApi19.getName(this.mContext, this.mUri);
    }

    public String getType() {
        return DocumentsContractApi19.getType(this.mContext, this.mUri);
    }

    public boolean isDirectory() {
        return DocumentsContractApi19.isDirectory(this.mContext, this.mUri);
    }

    public boolean isFile() {
        return DocumentsContractApi19.isFile(this.mContext, this.mUri);
    }

    public boolean isVirtual() {
        return DocumentsContractApi19.isVirtual(this.mContext, this.mUri);
    }

    public long lastModified() {
        return DocumentsContractApi19.lastModified(this.mContext, this.mUri);
    }

    public long length() {
        return DocumentsContractApi19.length(this.mContext, this.mUri);
    }

    public boolean canRead() {
        return DocumentsContractApi19.canRead(this.mContext, this.mUri);
    }

    public boolean canWrite() {
        return DocumentsContractApi19.canWrite(this.mContext, this.mUri);
    }

    public boolean delete() {
        return DocumentsContractApi19.delete(this.mContext, this.mUri);
    }

    public boolean exists() {
        return DocumentsContractApi19.exists(this.mContext, this.mUri);
    }

    public DocumentFile[] listFiles() {
        Uri[] listFiles = DocumentsContractApi21.listFiles(this.mContext, this.mUri);
        DocumentFile[] documentFileArr = new DocumentFile[listFiles.length];
        for (int i = 0; i < listFiles.length; i++) {
            documentFileArr[i] = new TreeDocumentFile(this, this.mContext, listFiles[i]);
        }
        return documentFileArr;
    }

    public boolean renameTo(String str) {
        str = DocumentsContractApi21.renameTo(this.mContext, this.mUri, str);
        if (str == null) {
            return false;
        }
        this.mUri = str;
        return true;
    }
}
