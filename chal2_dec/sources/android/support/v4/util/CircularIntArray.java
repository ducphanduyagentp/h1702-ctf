package android.support.v4.util;

public final class CircularIntArray {
    private int mCapacityBitmask;
    private int[] mElements;
    private int mHead;
    private int mTail;

    private void doubleCapacity() {
        int length = this.mElements.length;
        int i = length - this.mHead;
        int i2 = length << 1;
        if (i2 < 0) {
            throw new RuntimeException("Max array capacity exceeded");
        }
        Object obj = new int[i2];
        System.arraycopy(this.mElements, this.mHead, obj, 0, i);
        System.arraycopy(this.mElements, 0, obj, i, this.mHead);
        this.mElements = obj;
        this.mHead = 0;
        this.mTail = length;
        this.mCapacityBitmask = i2 - 1;
    }

    public CircularIntArray() {
        this(8);
    }

    public CircularIntArray(int i) {
        if (i < 1) {
            throw new IllegalArgumentException("capacity must be >= 1");
        } else if (i > 1073741824) {
            throw new IllegalArgumentException("capacity must be <= 2^30");
        } else {
            if (Integer.bitCount(i) != 1) {
                i = Integer.highestOneBit(i - 1) << 1;
            }
            this.mCapacityBitmask = i - 1;
            this.mElements = new int[i];
        }
    }

    public void addFirst(int i) {
        this.mHead = (this.mHead - 1) & this.mCapacityBitmask;
        this.mElements[this.mHead] = i;
        if (this.mHead == this.mTail) {
            doubleCapacity();
        }
    }

    public void addLast(int i) {
        this.mElements[this.mTail] = i;
        this.mTail = (this.mTail + 1) & this.mCapacityBitmask;
        if (this.mTail == this.mHead) {
            doubleCapacity();
        }
    }

    public int popFirst() {
        if (this.mHead == this.mTail) {
            throw new ArrayIndexOutOfBoundsException();
        }
        int i = this.mElements[this.mHead];
        this.mHead = (this.mHead + 1) & this.mCapacityBitmask;
        return i;
    }

    public int popLast() {
        if (this.mHead == this.mTail) {
            throw new ArrayIndexOutOfBoundsException();
        }
        int i = (this.mTail - 1) & this.mCapacityBitmask;
        int i2 = this.mElements[i];
        this.mTail = i;
        return i2;
    }

    public void clear() {
        this.mTail = this.mHead;
    }

    public void removeFromStart(int i) {
        if (i > 0) {
            if (i > size()) {
                throw new ArrayIndexOutOfBoundsException();
            }
            this.mHead = this.mCapacityBitmask & (this.mHead + i);
        }
    }

    public void removeFromEnd(int i) {
        if (i > 0) {
            if (i > size()) {
                throw new ArrayIndexOutOfBoundsException();
            }
            this.mTail = this.mCapacityBitmask & (this.mTail - i);
        }
    }

    public int getFirst() {
        if (this.mHead != this.mTail) {
            return this.mElements[this.mHead];
        }
        throw new ArrayIndexOutOfBoundsException();
    }

    public int getLast() {
        if (this.mHead == this.mTail) {
            throw new ArrayIndexOutOfBoundsException();
        }
        return this.mElements[this.mCapacityBitmask & (this.mTail - 1)];
    }

    public int get(int i) {
        if (i >= 0) {
            if (i < size()) {
                return this.mElements[this.mCapacityBitmask & (this.mHead + i)];
            }
        }
        throw new ArrayIndexOutOfBoundsException();
    }

    public int size() {
        return this.mCapacityBitmask & (this.mTail - this.mHead);
    }

    public boolean isEmpty() {
        return this.mHead == this.mTail;
    }
}