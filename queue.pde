public class ErrorQueue extends ArrayList {
    private int max_size;

    public ErrorQueue(int size){
        this.max_size = size;
    }

    public boolean add(float k){
        boolean r = super.add(k);
        if (this.size() > this.max_size){
            removeRange(0, this.size() - this.max_size - 1);
        }
        return r;
    }
    
    public float sum() {
        float s = 0;
        for (Object el : this)
            s += (float) el;
        return s;
    }

    public float mean() {
        return this.sum() / this.size();
    }
    
    public float delta() {
        int s = this.size();
        if (s < 2) return 0;
        return (float) this.get(s - 1) - (float) this.get(s - 2);
    }
}