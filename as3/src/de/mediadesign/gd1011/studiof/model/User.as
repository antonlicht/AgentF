/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    public class User
    {
        private var name:String;
        private var points:int;

        public function User(name:String)
        {
            this.name = name;
            points = 0;
        }
    }
}
