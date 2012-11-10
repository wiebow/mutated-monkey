
  
Strict


Interface Value
	
	Method Value:Float() Property
	
End Interface


'summary: A configurable simple single value
Class SimpleValue Implements Value
	
	Private
	
	Field value:Float
	Field nextValue:Float
	
	Private
	
	
	Method New(v:Float)
		value = v
	End Method
	
	Method Value:Float() Property
		Return value
	End Method
	
	Method Value:Float(v:Float) Property
		value = v
	End Method

End Class


Class RandomValue Implements Value
	
	Private
	Field value:Float
	Public
	
	Method New(v:Float)
		value = v
	End Method
	
	Method Value:Float(time:Float) Property
		Return Rnd(0, value)
	End Method
	
	Method Value:Float() Property
		Return value
	End Method
	
	Method Value:Float(v:Float) Property
		value = v
	End Method	
	
End Class




Class LinearInterpolator Implements Value
	

End Class





        / * *
         * A value computed based on linear interpolation between a set of points
         * 
         * @author void
         */
        public class LinearInterpolator implements Value {
                /** The list of points to interpolate between */
                private ArrayList curve;
                /** True if this interpolation value is active */
                private boolean active;
                /** The minimum value in the data set */
                private int min;
                /** The maximum value in the data set */
                private int max;

                /**
                 * Create a new interpolated value
                 * 
                 * @param curve The set of points to interpolate between
                 * @param min The minimum value in the dataset
                 * @param max The maximum value possible in the dataset
                 */
                public LinearInterpolator(ArrayList curve, int min, int max) {
                        this.curve = curve;
                        this.min = min;
                        this.max = max;
                        this.active = false;
                }

                /**
                 * Set the collection of data points to interpolate between
                 * 
                 * @param curve The list of data points to interpolate between
                 */
                public void setCurve(ArrayList curve) {
                        this.curve = curve;
                }

                /**
                 * The list of data points to interpolate between
                 * 
                 * @return A list of Vector2f of the data points to interpolate between
                 */
                public ArrayList getCurve() {
                        return curve;
                }

                /**
                 * Get the value to use at a given time value
                 * 
                 * @param t The time value (expecting t in [0,1])
                 * @return The value to use at the specified time
                 */
                public float getValue(float t) {
                        // first: determine the segment we are in
                        Vector2f p0 = (Vector2f) curve.get(0);
                        for (int i = 1; i < curve.size(); i++) {
                                Vector2f p1 = (Vector2f) curve.get(i);

                                if (t >= p0.getX() && t <= p1.getX()) {
                                        // found the segment
                                        float st = (t - p0.getX())
                                                        / (p1.getX() - p0.getX());
                                        float r = p0.getY() + st
                                                        * (p1.getY() - p0.getY());
                                        // System.out.println( "t: " + t + ", " + p0.x + ", " + p0.y
                                        // + " : " + p1.x + ", " + p1.y + " => " + r );

                                        return r;
                                }

                                p0 = p1;
                        }
                        return 0;
                }

                /**
                 * Check if this interpolated value should be used
                 * 
                 * @return True if this value is in use
                 */
                public boolean isActive() {
                        return active;
                }

                /**
                 * Indicate if this interpoalte value should be used
                 * 
                 * @param active True if this value should be used
                 */
                public void setActive(boolean active) {
                        this.active = active;
                }

                /**
                 * Get the maxmimum value possible in this data set
                 * 
                 * @return The maximum value possible in this data set
                 */
                public int getMax() {
                        return max;
                }

                /**
                 * Set the maximum value possible in this data set
                 * 
                 * @param max The maximum value possible in this data set
                 */
                public void setMax(int max) {
                        this.max = max;
                }

                /**
                 * Get the minimum value possible in this data set
                 * 
                 * @return The minimum value possible in this data set
                 */
                public int getMin() {
                        return min;
                }

                /**
                 * Set the minimum value possible in this data set
                 * 
                 * @param min The minimum value possible in this data set
                 */
                public void setMin(int min) {
                        this.min = min;
                }
        }

