/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:56
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model.components
{
    public class HighscoreEntry
    {
        public var name:String;
        public var points:int;

        public function HighscoreEntry(name:String = "", points:int = 0)
        {
            this.name = name;
            this.points = points;
        }
    }
}
